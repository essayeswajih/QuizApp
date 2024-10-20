import 'package:flutter/material.dart';

// Enum to represent possible answers
enum AnswerOption { a, b, c, d }

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Store the selected answer
  AnswerOption? _selectedOption;
  int _score = 0;
  int _questionIndex = 0;

  // Questions and answers about programming languages
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What language is used for Android app development?',
      'answers': [
        {'text': 'Python', 'value': AnswerOption.a},
        {'text': 'Java', 'value': AnswerOption.b},
        {'text': 'C++', 'value': AnswerOption.c},
        {'text': 'Ruby', 'value': AnswerOption.d},
      ],
      'correctAnswer': AnswerOption.b,
    },
    {
      'question': 'Which language is known for web development?',
      'answers': [
        {'text': 'C', 'value': AnswerOption.a},
        {'text': 'JavaScript', 'value': AnswerOption.b},
        {'text': 'Swift', 'value': AnswerOption.c},
        {'text': 'Kotlin', 'value': AnswerOption.d},
      ],
      'correctAnswer': AnswerOption.b,
    },
    {
      'question': 'Which programming language is primarily used for iOS development?',
      'answers': [
        {'text': 'Swift', 'value': AnswerOption.a},
        {'text': 'JavaScript', 'value': AnswerOption.b},
        {'text': 'Python', 'value': AnswerOption.c},
        {'text': 'PHP', 'value': AnswerOption.d},
      ],
      'correctAnswer': AnswerOption.a,
    },
    {
      'question': 'What is Dart used for?',
      'answers': [
        {'text': 'Backend development', 'value': AnswerOption.a},
        {'text': 'Mobile app development', 'value': AnswerOption.b},
        {'text': 'Data science', 'value': AnswerOption.c},
        {'text': 'Game development', 'value': AnswerOption.d},
      ],
      'correctAnswer': AnswerOption.b,
    },
    {
      'question': 'Which language is best known for system-level programming?',
      'answers': [
        {'text': 'Java', 'value': AnswerOption.a},
        {'text': 'Ruby', 'value': AnswerOption.b},
        {'text': 'C', 'value': AnswerOption.c},
        {'text': 'Python', 'value': AnswerOption.d},
      ],
      'correctAnswer': AnswerOption.c,
    },
  ];

  // Check the answer and move to the next question
  void _checkAnswer() {
    if (_selectedOption == _questions[_questionIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
        _selectedOption = null; // Reset the selected option for the next question
      } else {
        _showScore();
      }
    });
  }

  // Show the final score dialog
  void _showScore() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Finished'),
        content: Text('Your score is $_score/${_questions.length}.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _questionIndex = 0;
                _score = 0;
                _selectedOption = null; // Reset selection
              });
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Programming Quiz',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
        color: Colors.grey[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png', width: 200, height: 200),
              const SizedBox(height: 20),
              Text(
                'Question ${_questionIndex+1}/5',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                _questions[_questionIndex]['question'],
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Column(
                children: _questions[_questionIndex]['answers']
                    .map<Widget>((answer) {
                  return ListTile(
                    title: Text(answer['text']),
                    leading: Radio<AnswerOption>(
                      value: answer['value'],
                      groupValue: _selectedOption,
                      onChanged: (AnswerOption? value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                ),
                child: const Text('Next Question',style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

