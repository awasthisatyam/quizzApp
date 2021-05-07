import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'questions.dart';
import 'dart:math';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> iconList = [];

  int questionNumber = 0;
  int totalQuestion = 13;
  int correct = 0;

  void changeQuestionNumber() {
    if (questionNumber + 1 < ques.length) questionNumber++;
  }

  void addIcon(bool choice) {
    bool correctAnswer = ques[questionNumber].a;
    if (choice == correctAnswer) {
      iconList.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
      correct++;
    }

    if (choice != correctAnswer)
      iconList.add(
        Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      );
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                ques[questionNumber].q,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                if (questionNumber + 1 >= ques.length) {
                  Alert(
                          context: context,
                          title: "Quiz End",
                          desc:
                              "You have answered all questions and your score is ${((correct / totalQuestion) * 100).round()} %")
                      .show();
                } else {
                  setState(() {
                    addIcon(true);
                    changeQuestionNumber();
                  });
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (questionNumber + 1 >= ques.length) {
                  Alert(
                          context: context,
                          title: "Quiz End",
                          desc:
                              "You have answered all questions and your score is ${((correct / totalQuestion) * 100).round()} %")
                      .show();
                } else {
                  setState(() {
                    addIcon(false);
                    changeQuestionNumber();
                  });
                }
              },
            ),
          ),
        ),
        Row(
          children: iconList,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
