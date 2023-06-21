import 'package:flutter/material.dart';
import 'package:quizz/app_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AppBrain appBrain = AppBrain();

void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Quizz'),
          backgroundColor: Colors.grey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ExamPage(),
        ),
      ),
    );
  }
}

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});
  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List<Widget> answerResult = [];
  int rightAnswers = 0;
  void badMark() {
    answerResult.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Icon(Icons.thumb_down, color: Colors.red),
    ));
  }

  void goodMark() {
    answerResult.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Icon(Icons.thumb_up, color: Colors.green),
    ));
  }

  void checkAnswer(bool picked) {
    bool correctAnswer = appBrain.getQuestionAnswer();
    setState(() {
      if (correctAnswer == picked) {
        goodMark();
        rightAnswers++;
      } else {
        badMark();
      }
    });
     int count = appBrain.countQuestions();
    if (appBrain.isFinished() == true) {
      Alert(
        context: context,
        title: "QUIZZ COMPLETED",
        desc: "Your Score is $rightAnswers on $count .",
        buttons: [
          DialogButton(
            child: Text(
              "Start again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      appBrain.reset();
      answerResult = [];
      rightAnswers = 0;
    } else {
      appBrain.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: answerResult,
        ),
        Expanded(
            flex: 5,
            child: Column(children: [
              Image.asset(appBrain.getQuestionImage()),
              SizedBox(height: 20),
              Text(
                appBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              )
            ])),
        Expanded(
            // flex: 1,
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(
              'true',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              checkAnswer(true);
            },
          ),
        )),
        Expanded(
            // flex: 1,
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 244, 54, 54)),
            child: Text(
              'false',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              checkAnswer(false);
            },
          ),
        ))
      ],
    );
  }
}
