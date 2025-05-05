import 'package:flutter/material.dart';
import 'dart:async';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  final List<Map<String, dynamic>> personalityQuizzes = [
    {
      'title': 'RIASEC TEST',
      'questions': 42,
      'time': '42 min',
      'rating': 4.8,
      'image': 'Assets/RIASEC.png',
    },
    {
      'title': 'Big Five Assessment',
      'questions': 30,
      'time': '30 min',
      'rating': 4.9,
      'image': 'Assets/Big five.png',
    }
  ];
  final List<Map<String, dynamic>> skillsQuizzes = [
    {
      'title': 'Critical Thinking',
      'questions': 25,
      'time': '25 min',
      'rating': 4.7,
      'image': 'Assets/critical thinking.png',
    },
    {
      'title': 'Problem Solving',
      'questions': 35,
      'time': '35 min',
      'rating': 4.6,
      'image': 'Assets/Problem solving.png',
    }
  ];
  List<String> completedQuizzes = [];
  Map<String, dynamic>? selectedQuiz;

  void markQuizAsCompleted(String quizTitle) {
    setState(() {
      if (!completedQuizzes.contains(quizTitle)) {
        completedQuizzes.add(quizTitle);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Let's test your knowledge"),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Personality'),
              Tab(text: 'Skills'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  QuizList(
                    quizzes: personalityQuizzes,
                    onSelect: (quiz) {
                      setState(() {
                        selectedQuiz = quiz;
                      });
                    },
                    selectedQuiz: selectedQuiz,
                  ),
                  QuizList(
                    quizzes: skillsQuizzes,
                    onSelect: (quiz) {
                      setState(() {
                        selectedQuiz = quiz;
                      });
                    },
                    selectedQuiz: selectedQuiz,
                  ),
                ],
              ),
            ),
            if (selectedQuiz != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizDetailScreen(quiz: selectedQuiz!),
                      ),
                    );
                  },
                  child: Text(
                    'Start Quiz',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final List<Map<String, dynamic>> quizzes;
  final Function(Map<String, dynamic>) onSelect;
  final Map<String, dynamic>? selectedQuiz;

  const QuizList({super.key, required this.quizzes, required this.onSelect, required this.selectedQuiz});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final quiz = quizzes[index];
        bool isSelected = selectedQuiz == quiz;

        return GestureDetector(
          onTap: () => onSelect(quiz),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: isSelected ? BorderSide(color: Colors.blue, width: 2) : BorderSide.none,
            ),
            elevation: 4,
            child: ListTile(
              leading: Image.asset(quiz['image'], width: 50, height: 50),
              title: Text(quiz['title'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${quiz['questions']} Questions  •  ${quiz['time']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text(quiz['rating'].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuizDetailScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;

  const QuizDetailScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Quiz"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quiz['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("⭐ ${quiz['rating']}", style: TextStyle(fontSize: 18, color: Colors.amber)),
            SizedBox(height: 16),
            Text("${quiz['questions']} Questions - ${quiz['time']}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text("Brief explanation about this quiz", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("10 points for a correct answer. Earn your first badge!"),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                    settings: RouteSettings(arguments: quiz['title'])
                  ),
                );
                print("Quiz type: ${quiz['title']}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> questions = [
    {
      'type': 'Big Five Assessment',
      'questions': [
        {
          'text': 'I Am the life of the party.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Feel little concern for others. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Am always prepared.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Get stressed out easily. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Have a rich vocabulary.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
        {
          'text': 'I Don\'t talk a lot. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          "text": "I Am interested in people.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Agreeableness',
        },
        {
          "text": "I Leave my belongings around.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Conscientiousness',
        },
        {
          "text": "I Am relaxed most of the time.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Neuroticism',
        },
        {
          "text": "I Have difficulty understanding abstract ideas.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Openness to Experience',
        },
        {
          "text": "I Feel comfortable around people.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Extroversion',
        },
        {
          "text": "I Insult people.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Agreeableness',
        },
        {
          "text": "I Pay attention to details.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Conscientiousness',
        },
        {
          "text": "I Worry about things.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Neuroticism',
        },
        {
          "text": "I Have a vivid imagination.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Openness to Experience',
        },
        {
          "text": "I Keep in the background.",
          "answer": null,
          "options": [
            "Strongly Agree",
            "Slightly Agree",
            "Neutral",
            "Slightly Disagree",
            "Strongly Disagree"
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Sympathize with others\' feelings.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Make a mess of things.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Seldom feel blue.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Am not interested in abstract ideas. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
        {
          'text': 'I Start conversations.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Am not interested in other people\'s problems.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Get chores done right away. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Am easily disturbed. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Have excellent ideas.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
        {
          'text': 'I Have little to say.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Have a soft heart.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Often forget to put things back in their proper place. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Get upset easily. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Do not have a good imagination. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
        {
          'text': 'I Talk to a lot of different people at parties.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Am not really interested in others. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Like order.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Change my mood a lot. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Am quick to understand things. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
        {
          'text': 'I Don\'t like to draw attention to myself. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Take time out for others. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Shirk my duties. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Have frequent mood swings. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Use difficult words. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
        {
          'text': 'I Don\'t mind being the center of attention. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Feel others\' emotions.',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Follow a schedule. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Get irritated easily. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Spend time reflecting on things. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
        {
          'text': 'I Am quiet around strangers. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Extroversion',
        },
        {
          'text': 'I Make people feel at ease. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Agreeableness',
        },
        {
          'text': 'I Am exacting in my work. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Conscientiousness',
        },
        {
          'text': 'I Often feel blue. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Neuroticism',
        },
        {
          'text': 'I Am full of ideas. ',
          'answer': null,
          'options': [
            'Strongly Agree',
            'Slightly Agree',
            'Neutral',
            'Slightly Disagree',
            'Strongly Disagree'
          ],
          'type': 'Openness to Experience',
        },
      ]
    },
    {
      'type': 'RIASEC TEST',
      'questions': [
        {
          'text': 'I like to work on cars',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Realistic',
        },
        {
          'text': 'I like to do puzzles',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Investigative',
        },
        {
          'text': 'I am good at working independently',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Artistic',
        },
        {
          'text': 'I like to work in teams',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Social',
        },
        {
          'text': 'I am an ambitious person, I set goals for myself',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to organize things,(files, desks/offices)',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to build things',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Realistic',
        },
        {
          'text': 'I like to read about art and music',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Artistic',
        },
        {
          'text': 'I like to have clear instructions to follow',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to try to influence or persuade people',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to do experiments',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Investigative',
        },
        {
          'text': 'I like to teach or train people',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Social',
        },
        {
          'text': 'I like trying to help people solve their problems',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Social',
        },
        {
          'text': 'I like to take care of animals',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Realistic',
        },
        {
          'text': 'I wouldn\'t mind working 8 hours per day in an office',
          'answer': null,
          'options': [
            'Agree', 'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like selling things',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I enjoy creative writing',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Artistic',
        },
        {
          'text': 'I enjoy science',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Investigative',
        },
        {
          'text': 'I am quick to take on new responsibilities',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I am interested in healing people',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Social',
        },
        {
          'text': 'I enjoy trying to figure out how things work',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Investigative',
        },
        {
          'text': 'I like putting things together or assembling things',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Realistic',
        },
        {
          'text': 'I am a creative person',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Artistic',
        },
        {
          'text': 'I pay attention to details',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to do filing or typing',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to analyze things (problems/situations)',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Investigative',
        },
        {
          'text': 'I like to play instruments or sing',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Artistic',
        },
        {
          'text': 'I enjoy learning about other cultures',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Social',
        },
        {
          'text': 'I would like to start my own business',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to cook',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Realistic',
        },
        {
          'text': 'I like acting in plays',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Artistic',
        },
        {
          'text': 'I am a practical person',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Realistic',
        },
        {
          'text': 'I like working with numbers or charts',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Investigative',
        },
        {
          'text': 'I like to get into discussions about issues',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Social',
        },
        {
          'text': 'I am good at keeping records of my work',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like to lead',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I like working outdoors',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Realistic',
        },
        {
          'text': 'I would like to work in an office',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        },
        {
          'text': 'I\'m good at math',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Investigative',
        },
        {
          'text': 'I like helping people',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Social',
        },
        {
          'text': 'I like to draw',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Artistic',
        },
        {
          'text': 'I like to give speeches',
          'answer': null,
          'options': [
            'Agree',
            'Don\'t Agree'
          ],
          'type': 'Enterprising',
        }
      ]
    },
    {
      'type': 'Critical Thinking',
      'questions': [
        {
          "text": "Do they have a 4th of July in England?",
          "answer": null,
          "correct_answer": "Yes",
          "options": [
            "Yes",
            "No",
            "Maybe",
            "I don't know"
          ]
        },
        {
          "text": "How many birthdays does the average man have?",
          "answer": null,
          "correct_answer": "One per year",
          "options": [
            "78",
            "65.5",
            "One per year",
            "None"
          ]
        },
        {
          "text": "Some months have 31 days, how many have 28?",
          "answer": null,
          "correct_answer": "All months have (at least) 28 days",
          "options": [
            "One month and that is February",
            "February, every 4 years.",
            "All months have (at least) 28 days",
            "None of the above"
          ]
        },
        {
          "text": "A woman gives a beggar 50 cents, the woman is the beggar's sister, but the beggar is not the woman's brother. How come?",
          "answer": null,
          "correct_answer": "The beggar is the woman's sister!",
          "options": [
            "The beggar is the woman's sister!",
            "Not possible.",
            "The beggar is an in-law.",
            "The woman is the beggar."
          ]
        },
        {
          "text": "Why can't a man living in the USA be buried in Canada?",
          "answer": null,
          "correct_answer": "The man is not dead yet!",
          "options": [
            "The Canadian Government does not allow Americans to be buried in Canada.",
            "The man is not dead yet!",
            "It is a trick question and the man is a Canadian living in America.",
            "The man is living between the border."
          ]
        },
        {
          "text": "How many outs are there in an inning?",
          "answer": null,
          "correct_answer": "There are 6 adults.",
          "options": [
            "There are 3 adults",
            "There are 6 adults.",
            "There are 4 adults.",
            "None of the above"
          ]
        },
        {
          "text": "Is it legal for a man in California to marry his widow's sister?",
          "answer": null,
          "correct_answer": "No, the man would be dead",
          "options": [
            "Yes, as long as she is alive.",
            "Yes, if the man is from California.",
            "You can't marry like this in California.",
            "No, the man would be dead"
          ]
        },
        {
          "text": "Two women play five games of checkers. Each woman wins the same number of games. There are no ties. Explain this.",
          "answer": null,
          "correct_answer": "The women are not playing each other.",
          "options": [
            "Because they aren't wearing ties!",
            "The women are not playing each other.",
            "These two women are playing men.",
            "Women don't wear ties."
          ]
        },
        {
          "text": "Divide 30 by 1/2 and add 10. What is the answer?",
          "answer": null,
          "correct_answer": "70",
          "options": [
            "25",
            "50",
            "65",
            "70"
          ]
        },
        {
          "text": "A man builds a house rectangular in shape. All sides have southern exposure. A bear walks by the house. What color is the bear? Why?",
          "answer": null,
          "correct_answer": "White",
          "options": [
            "Black...bears are black",
            "White",
            "Brown...the house is on a steep slope",
            "There is no answer and this is a stupid question."
          ]
        },
        {
          "text": "There are 3 apples and you take away 2. How many do you have?",
          "answer": null,
          "correct_answer": "Two...",
          "options": [
            "One...",
            "Two...",
            "Three...",
            "Four"
          ]
        },
        {
          "text": "I have two U.S. coins totaling 55 cents. One is not a nickel. What are the coins?",
          "answer": null,
          "correct_answer": "A fifty cents piece and a nickel",
          "options": [
            "I have no idea",
            "A fifty cents piece and a nickel",
            "No answer",
            "100 yen"
          ]
        },
        {
          "text": "If you have only one match and you walked into a room where there was an oil burner, a kerosene lamp, and a wood-burning stove, what would you light first?",
          "answer": null,
          "correct_answer": "The thing in my hand",
          "options": [
            "The kerosene lamp because it is easier",
            "The oil burner.",
            "The wood burning stove...",
            "The thing in my hand"
          ]
        },
        {
          "text": "How far can a forester run into the woods?",
          "answer": null,
          "correct_answer": "I don't know",
          "options": [
            "All the way into the woods",
            "Halfway into the woods...",
            "You don't actually run 'into' woods.",
            "I don't know"
          ]
        },
        {
          "text": "What was the president's name in 1950?",
          "answer": null,
          "correct_answer": "Bill Clinton",
          "options": [
            "Harry Truman",
            "John Kennedy",
            "President Eisenhower",
            "Bill Clinton"
          ]
        },
        {
          "text": "A forester has 17 trees, and all but 9 die. How many are left?",
          "answer": null,
          "correct_answer": "9 trees",
          "options": [
            "8 trees",
            "9 trees",
            "The first 8",
            "I don't know"
          ]
        },
        {
          "text": "How many 2-cent stamps are in a dozen?",
          "answer": null,
          "correct_answer": "Twelve",
          "options": [
            "Six",
            "Twelve",
            "Eighteen",
            "Twenty-four"
          ]
        },
        {
          "text": "A 4 x 4 planting density per acre is twice as many trees as an 8 x 8 spacing.",
          "answer": null,
          "correct_answer": "True or False",
          "options": [
            "True",
            "False",
            "True or False",
            "I don't know"
          ]
        },
        {
          "text": "Name the greatest of all inventors.",
          "answer": null,
          "correct_answer": "Einstein",
          "options": [
            "Accident",
            "Gertrude Stein",
            "Einstein",
            "Alexander Graham Bell"
          ]
        },
        {
          "text": "Are creative skill practice books for children for the enrichment of their creative thinking?",
          "answer": null,
          "correct_answer": "Creative books",
          "options": [
            "Enrichment books",
            "Idea books",
            "Integrated books",
            "Creative books"
          ]
        }
      ]
    },
    {
      'type': 'Problem Solving',
      'questions': [
          {
            'text': 'You are going out for a meal with a friend. The time is 5pm and you have to meet her at 8pm. How long is it until you need to meet her?',
            'answer': null,
            'correct_answer': '3 hours',
            'options': [
              '2 hours',
              '4 hours',
              '3 hours'
            ]
          },
        {
          "text": "There are 27 people waiting for a coach. When the coach arrives it only has room for 15 people. How many people will have to wait for the next coach?",
          "answer": null,
          "correct_answer": "12",
          "options": ["12", "11", "16", "13"]
        },
        {
          "text": "At a shopping centre you buy a skirt which costs \u00a317.00 and a top which costs \u00a38. How much do you spend in total?",
          "answer": null,
          "correct_answer": "\u00a325",
          "options": ["\u00a326", "\u00a325", "\u00a324", "\u00a328"]
        },
        {
          "text": "A swimming pool is 10 metres in width. If you swim across and back twice, how far will you swim?",
          "answer": null,
          "correct_answer": "40 metres",
          "options": ["20 metres", "30 metres", "60 metres", "40 metres"]
        },
        {
          "text": "A furniture shop has had a delivery of tables and a delivery of chairs. There are 3 tables and 18 chairs. How many chairs should be matched with each table?",
          "answer": null,
          "correct_answer": "6",
          "options": ["15", "8", "4", "6"]
        },
        {
          "text": "A car park has spaces for 75 cars but 110 turn up on a Saturday morning. How many cars cannot get into the car park?",
          "answer": null,
          "correct_answer": "35",
          "options": ["30", "45", "185", "35"]
        },
        {
          "text": "You go to a fast food outlet and order a burger at \u00a32.80 and a tea at \u00a31.20. How much do you pay?",
          "answer": null,
          "correct_answer": "\u00a34.00",
          "options": ["\u00a33.00", "\u00a31.60", "\u00a35.00", "\u00a34.00"]
        },
        {
          "text": "A gardener needs three lengths of fencing for a garden. He needs 2 lengths measuring 10 metres and one length measuring 5 metres. How much does he need altogether?",
          "answer": null,
          "correct_answer": "25 metres",
          "options": ["15 metres", "25 metres", "52 metres", "20 metres"]
        },
        {
          "text": "You need 100 tiles to tile your bathroom wall. The tiles are sold in boxes of 5. How many boxes will you need to buy?",
          "answer": null,
          "correct_answer": "20",
          "options": ["15", "20", "10", "50"]
        },
        {
          "text": "6 flatmates go to the supermarket. They decide to divide the cost up between them. If they pay \u00a336 in total, how much will each flatmate have to pay?",
          "answer": null,
          "correct_answer": "\u00a36",
          "options": ["\u00a35", "16", "\u00a36", "\u00a38"]
        },
        {
          "text": "A tree is 3 metres tall and is growing 25 cm each year, how high will it be in 3 years?",
          "answer": null,
          "correct_answer": "3 m 75 cm",
          "options": ["78 cm", "4.35 m", "3 m 75 cm", "3 075 cm"]
        },
        {
          "text": "The price of some fruit is 50% more expensive in winter than in summer. If strawberries cost \u00a31.60 for a punnet in summer, how much would they cost in winter?",
          "answer": null,
          "correct_answer": "\u00a32.40",
          "options": ["\u00a32.00", "\u00a32.40", "80p", "\u00a32.50"]
        },
        {
          "text": "You are on a bus in slow-moving traffic. The average speed of the bus is 10 mph. How long will it take to travel 5 miles?",
          "answer": null,
          "correct_answer": "30 minutes",
          "options": ["30 minutes", "45 minutes", "1 hour", "50 minutes"]
        },
        {
          "text": "You need 100 tiles to cover a wall. The tiles are sold in boxes of 9. How many boxes will you need to buy?",
          "answer": null,
          "correct_answer": "12",
          "options": ["10", "11", "12", "13"]
        },
        {
          "text": "The temperature in London is 5°C, while in Oslo it is -3°C. What is the difference in temperature?",
          "answer": null,
          "correct_answer": "8°",
          "options": ["8°", "2°", "15°", "6°"]
        },
        {
          "text": "A cyclist goes 14 miles to work each morning and the same back in the evening. How many miles will the cyclist do to work and back each day?",
          "answer": null,
          "correct_answer": "28 miles",
          "options": ["70 miles", "42 miles", "28 miles", "27 miles"]
        },
        {
          "text": "You have an 8-hour DVD and need to know how many 50-minute programmes you can record, and how much space will be left over.",
          "answer": null,
          "correct_answer": "9 programmes + 30 minutes space",
          "options": [
            "9 programmes + 30 minutes space",
            "8 programmes",
            "9 programmes + 20 minutes space",
            "8 programmes + 30 minutes space"
          ]
        },
        {
          "text": "Your friend is training for a 10-mile run. She aims to do training runs of 30 miles a week. If she trains for 5 days a week and runs the same distance each day, how many miles will she run each day?",
          "answer": null,
          "correct_answer": "6 miles",
          "options": ["5 miles", "3 miles", "6 miles", "10 miles"]
        },
        {
          "text": "A club trip has been organised. If 4 people are travelling together in a car, how many cars will be needed for 25 people?",
          "answer": null,
          "correct_answer": "7 cars",
          "options": ["4 cars", "8 cars", "6 cars", "7 cars"]
        },
        {
          "text": "An exercise machine costs £120 by mail order. If it can be paid for in 12 equal instalments, what will be the amount of each instalment?",
          "answer": null,
          "correct_answer": "£10.00",
          "options": ["£10.00", "£12.00", "£22.00", "£12.20"]
        },
        {
          "text": "A shop buys DVDs for £5 each. It sells them at £11 each, or 3 for £24. How much profit would they make on selling 2 DVDs?",
          "answer": null,
          "correct_answer": "£12.00",
          "options": ["£16.00", "£12.00", "£10.00", "£11.00"]
        },
        {
          "text": "A car park has 1 000 spaces. When the car park is three-quarters full, how many spaces will still be free?",
          "answer": null,
          "correct_answer": "250",
          "options": ["750", "25", "75", "250"]
        },
        {
          "text": "You pay £1.80 for a 2 litre bottle of cola. What is the cost per litre?",
          "answer": null,
          "correct_answer": "90p",
          "options": ["£1.00", "90p", "80p", "70p"]
        },
        {
          "text": "In a survey of 600 people 25% said they could swim less than 100 m. The remainder said that they could swim 100 m or further. How many people said they could swim 100 m or further?",
          "answer": null,
          "correct_answer": "450",
          "options": ["500", "550", "600", "450"]
        },
        {
          "text": "In a quiz you score 5 for a correct answer and -2 for a wrong answer. What would be the score for 8 correct and 4 wrong?",
          "answer": null,
          "correct_answer": "32",
          "options": ["9", "48", "36", "32"]
        },

        {
          "text": "A man won £6 000 in a competition. When he went to collect his prize money hotel and travel expenses came to £250. He also spent a further £500 on celebrating. How much of his prize money was left?",
          "answer": null,
          "correct_answer": "£5 250",
          "options": ["£5 200", "£5 500", "£5 250", "£5 400"]
        },

        {
          "text": "Have a look at the prices for car parking shown below.  \nUp to 1 hour is 90p  \n1 to 2 hours is £1.50  \n2 to 3 hours is £2.30  \nYour friend parks at 14:15. She only has £2 in cash. When will she have to leave the car park?",
          "answer": null,
          "correct_answer": "16:15",
          "options": ["16:15", "16:15", "16:15", "16:15"]
        },

        {
          "text": "A friend wants to buy a music system. There are two ways of paying:  \n1) £399 cash  \n2) £95 deposit then payments totalling £350  \nWhat is the difference in price?",
          "answer": null,
          "correct_answer": "£46",
          "options": ["£46", "£36", "£49", "£146"]
        },

        {
          "text": "The ingredients for 40 small buns include 400g butter and 160g of cherries. What amount of each would you need for 10 small buns?",
          "answer": null,
          "correct_answer": "100g butter and 40g cherries",
          "options": ["100g butter and 80g cherries", "200g butter and 80g cherries", "100g butter and 40g cherries", "100g butter and 60g cherries"]
        },

        {
          "text": "A child’s jacket is being made. It will need 3 buttonholes all evenly spaced. The distance from the bottom of the jacket to the top buttonhole will be 12 cm. What will be the distance between each buttonhole if there is a 2 cm space at the bottom?",
          "answer": null,
          "correct_answer": "2 cm",
          "options": ["2 cm", "5 cm", "4 cm", "3 cm"]
        },
      ]
    }
  ];
  late List<Map<String, dynamic>> selectedQuestions;
  late String quizName;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    quizName = ModalRoute.of(context)!.settings.arguments as String;
    selectedQuestions = questions.firstWhere((quiz) => quiz['type'] == quizName)['questions'];
  }

  void selectAnswer(String answer) {
    setState(() {
      selectedQuestions[currentQuestionIndex]['answer'] = answer;
    });

    Future.delayed(Duration(seconds: 1), () {
      print(selectedQuestions[currentQuestionIndex]['answer']);
      if (currentQuestionIndex < selectedQuestions.length - 1) {
        setState(() {
          currentQuestionIndex++;
        });
      }
      else {
        if (quizName == 'RIASEC TEST') {
          Map<String, int> scores = {
            'Realistic': 0,
            'Investigative': 0,
            'Artistic': 0,
            'Social': 0,
            'Enterprising': 0,
            'Conventional': 0,
          };

          for (var question in selectedQuestions) {
            if (question['answer'] == 'Agree') {
              scores[question['type']] = scores[question['type']]! + 1;
            }
          }
          print(scores);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizResultsPage(
                quizTitle: "Personality Quiz",
                totalScore: 30, // Change this to actual total score
                maxScore: 30, // Change this to actual max score
                categoryScores: scores,
                categoryLabels: {
                  "Extroversion": "Extremely Low",
                  "Agreeableness": "Low",
                  "Conscientiousness": "Moderate",
                  "Neuroticism": "High",
                  "Openness to Experience": "Extremely High",
                },
              ),
            ),
          );
        }
        else if (quizName == 'Critical Thinking') {
          int correctAnswers = 0;
          for (var question in selectedQuestions) {
            if (question['answer'] == question['correct_answer']) {
              correctAnswers++;
            }
          }
          print('Correct Answers: $correctAnswers');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizResultsPage(
                quizTitle: "Personality Quiz",
                totalScore: 30, // Change this to actual total score
                maxScore: 30, // Change this to actual max score
                categoryScores: {
                  "Extroversion": 6,
                  "Agreeableness": 12,
                  "Conscientiousness": 18,
                  "Neuroticism": 24,
                  "Openness to Experience": 30,
                },
                categoryLabels: {
                  "Extroversion": "Extremely Low",
                  "Agreeableness": "Low",
                  "Conscientiousness": "Moderate",
                  "Neuroticism": "High",
                  "Openness to Experience": "Extremely High",
                },
              ),
            ),
          );
        }
        else if (quizName == 'Big Five Assessment') {
          bool pos = true;
          int ctr = 1;
          Map<String, int> scores = {
            'Openness to Experience': 8,
            'Conscientiousness': 14,
            'Extroversion': 20,
            'Agreeableness': 14,
            'Neuroticism': 38,
          };
          for (var question in selectedQuestions) {
            if (pos) {
              if (question['answer'] == 'Strongly Agree') {
                scores[question['type']] = scores[question['type']]! + 5;
              }
              else if(question['answer'] == 'Slightly Agree') {
                scores[question['type']] = scores[question['type']]! + 4;
              }
              else if(question['answer'] == 'Neutral') {
                scores[question['type']] = scores[question['type']]! + 3;
              }
              else if(question['answer'] == 'Slightly Disagree') {
                scores[question['type']] = scores[question['type']]! + 2;
              }
              else if(question['answer'] == 'Strongly Disagree') {
                scores[question['type']] = scores[question['type']]! + 1;
              }
            }
            else {
              if (question['answer'] == 'Strongly Agree') {
                scores[question['type']] = scores[question['type']]! - 5;
              }
              else if(question['answer'] == 'Slightly Agree') {
                scores[question['type']] = scores[question['type']]! - 4;
              }
              else if(question['answer'] == 'Neutral') {
                scores[question['type']] = scores[question['type']]! - 3;
              }
              else if(question['answer'] == 'Slightly Disagree') {
                scores[question['type']] = scores[question['type']]! - 2;
              }
              else if(question['answer'] == 'Strongly Disagree') {
                scores[question['type']] = scores[question['type']]! - 1;
              }
            }
            ctr++;
            if (ctr == 5){
              pos = !pos;
              ctr = 1;
            }
          }
          print(scores);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizResultsPage(
                quizTitle: "Personality Quiz",
                totalScore: 30, // Change this to actual total score
                maxScore: 30, // Change this to actual max score
                categoryScores: {
                  "Extroversion": 6,
                  "Agreeableness": 12,
                  "Conscientiousness": 18,
                  "Neuroticism": 24,
                  "Openness to Experience": 30,
                },
                categoryLabels: {
                  "Extroversion": "Extremely Low",
                  "Agreeableness": "Low",
                  "Conscientiousness": "Moderate",
                  "Neuroticism": "High",
                  "Openness to Experience": "Extremely High",
                },
              ),
            ),
          );
        }
        else if (quizName == 'Problem Solving') {
          int correctAnswers = 0;
          for (var question in selectedQuestions) {
            if (question['answer'] == question['correct_answer']) {
              correctAnswers++;
            }
          }
          print('Correct Answers: $correctAnswers');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizResultsPage(
                quizTitle: "Personality Quiz",
                totalScore: 30, // Change this to actual total score
                maxScore: 30, // Change this to actual max score
                categoryScores: {
                  "Extroversion": 6,
                  "Agreeableness": 12,
                  "Conscientiousness": 18,
                  "Neuroticism": 24,
                  "Openness to Experience": 30,
                },
                categoryLabels: {
                  "Extroversion": "Extremely Low",
                  "Agreeableness": "Low",
                  "Conscientiousness": "Moderate",
                  "Neuroticism": "High",
                  "Openness to Experience": "Extremely High",
                },
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizName = ModalRoute.of(context)!.settings.arguments as String;
    double progress = (currentQuestionIndex + 1) / selectedQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${currentQuestionIndex + 1}/${selectedQuestions.length}'),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 20),
          Text(
            '${currentQuestionIndex + 1}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 3,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                selectedQuestions[currentQuestionIndex]['text'],
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          ...selectedQuestions[currentQuestionIndex]['options'].map<Widget>((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: ElevatedButton(
                onPressed: () => selectAnswer(option),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(option),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class QuizResultsPage extends StatelessWidget {
  final String quizTitle;
  final int totalScore;
  final int maxScore;
  final Map<String, int> categoryScores;
  final Map<String, String> categoryLabels;

  const QuizResultsPage({
    Key? key,
    required this.quizTitle,
    required this.totalScore,
    required this.maxScore,
    required this.categoryScores,
    required this.categoryLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Congratulations!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildScoreCircle(),
            const SizedBox(height: 20),
            Text(
              "Based on your selections, you are",
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...categoryScores.keys.map((category) => _buildCategoryBox(category)).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => QuizzesPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCircle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            "${((totalScore / maxScore) * 100).toInt()}%",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
          ),
          Text(
            "$totalScore of $maxScore",
            style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBox(String category) {
    int score = categoryScores[category]!;
    String label = categoryLabels[category]!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text("$score/30", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
