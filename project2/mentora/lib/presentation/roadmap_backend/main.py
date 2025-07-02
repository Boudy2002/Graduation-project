import os
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from openai import OpenAI
from dotenv import load_dotenv
from datetime import datetime
import json

# Load environment variables from .env file
load_dotenv()

app = FastAPI()

# Initialize OpenAI client
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

class RoadmapRequest(BaseModel):
    target_job_role: str

# Define Pydantic models for the expected JSON response from OpenAI
class LearningResource(BaseModel):
    name: str
    type: str
    link: str
    provider: str
    description: str

class Milestone(BaseModel):
    name: str
    description: str
    estimated_duration: str
    learning_goals: list[str]
    skills_acquired: list[str]
    resources: list[LearningResource]
    mini_project: str | None = None # Optional field

class RoadmapStage(BaseModel):
    stage_name: str
    overview: str
    milestones: list[Milestone]

class RoadmapResponseContent(BaseModel):
    id: str # This ID can be a UUID or a simple timestamp string
    user_id: str # Placeholder, or actual user ID if you implement authentication
    target_job_role: str
    generated_at: str # ISO formatted datetime string
    stages: list[RoadmapStage]

@app.post("/generate-roadmap", response_model=RoadmapResponseContent)
async def generate_roadmap_endpoint(request: RoadmapRequest):
    try:
        # Generate a unique ID and timestamp
        roadmap_id = f"roadmap_{datetime.now().strftime('%Y%m%d%H%M%S')}"
        generated_at = datetime.now().isoformat()

        response = client.chat.completions.create(
            model="gpt-3.5-turbo", # Using gpt-3.5-turbo as requested
            messages=[
                {
                    "role": "system",
                    "content": (
                        "You are an expert career guidance AI. "
                        "Your task is to generate a comprehensive, actionable, and highly detailed learning roadmap. "
                        "Break down each main stage into specific, sequential milestones. "
                        "For every milestone, provide clear learning goals, essential skills, recommended resources, and an estimated timeframe. "
                        "If applicable, include a small project for each milestone or stage. "
                        "Ensure the output is strictly in the specified JSON format. "
                        "The 'id' field should be a unique identifier, 'user_id' can be a placeholder or a default value, 'generated_at' should be an ISO 8601 timestamp."
                    )
                },
                {
                    "role": "user",
                    "content": (
                        f"Generate a highly detailed learning roadmap for a {request.target_job_role}. "
                        "The roadmap should be structured with main 'stages' (e.g., 'Foundations', 'Core Skills', 'Advanced Concepts', 'Specialization'). "
                        "Within each 'stage', define a list of 'milestones'. "
                        "For each 'milestone', include: "
                        "  - 'name' (string, e.g., 'Basic Python Syntax') "
                        "  - 'description' (string, detailed explanation of the milestone) "
                        "  - 'estimated_duration' (string, e.g., '2 weeks', '1 month') "
                        "  - 'learning_goals' (list of strings, specific objectives) "
                        "  - 'skills_acquired' (list of strings, key skills gained) "
                        "  - 'resources' (list of objects with 'name', 'type', 'link', 'provider', 'description') "
                        "  - 'mini_project' (optional string, a small project for this milestone). "
                        "Provide the full output as a JSON object containing: 'id', 'user_id', 'target_job_role', 'generated_at', and a list of 'stages'. "
                        "Each 'stage' object should contain 'stage_name' (e.g., 'Beginner'), 'overview' (string), and a list of 'milestones' as described above."
                    )
                },
            ],
            max_tokens=3000, # Increased max_tokens for more detail
            response_format={"type": "json_object"}
        )

        roadmap_json_string = response.choices[0].message.content
        roadmap_data = json.loads(roadmap_json_string)

        # Inject generated_at, id, and user_id into the response
        roadmap_data['id'] = roadmap_id
        roadmap_data['user_id'] = "default_user" # You can make this dynamic if needed
        roadmap_data['generated_at'] = generated_at

        return RoadmapResponseContent(**roadmap_data)

    except Exception as e:
        print(f"Error generating roadmap: {e}")
        raise HTTPException(status_code=500, detail=f"An internal server error occurred: {e}")