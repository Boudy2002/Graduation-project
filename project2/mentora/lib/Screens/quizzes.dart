import 'package:flutter/material.dart';
import 'dart:async';

class QuizzesPage extends StatefulWidget {
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

  Map<String, dynamic>? selectedQuiz;

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

  QuizList({required this.quizzes, required this.onSelect, required this.selectedQuiz});

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

  QuizDetailScreen({required this.quiz});

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
                  ),
                );
              },
              child: Text("Get Started"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> questions = [
    {'text': 'I like to work on cars', 'answer': null},
    {'text': 'I enjoy solving math problems', 'answer': null},
    {'text': 'I prefer working in teams', 'answer': null},
  ];

  void selectAnswer(bool answer) {
    setState(() {
      questions[currentQuestionIndex]['answer'] = answer;
    });
    Future.delayed(Duration(seconds: 1), () {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
        });
      } else {
        // Handle quiz completion
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${currentQuestionIndex + 1}/${questions.length}'),
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
                questions[currentQuestionIndex]['text'],
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => selectAnswer(true),
            child: Text('Agree'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => selectAnswer(false),
            child: Text('Don’t Agree'),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
