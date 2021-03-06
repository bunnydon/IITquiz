import 'package:flutter/material.dart';
import 'package:quizapp/Question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain questionBrain = new QuestionBrain();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  List<Icon> scorekeeper = [];
  int score = 0;

  void checkAnswer({bool userAnswer}) {
    setState(() {
      if (questionBrain.isFinished()) {
        Alert(
            context: context,
            title: "The number of question is finished",
            desc: "You have scored $score correct questions",
            buttons: [
              DialogButton(
                child: Text(
                  "PLAY AGAIN :)",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  score = 0;
                  Navigator.pop(context);
                },
              )
            ]).show();
        questionBrain.reset();
        scorekeeper.clear();
      } else {
        if (questionBrain.getAnswerResult() == userAnswer) {
          scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
            size: 24,
          ));
          score++;
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
            size: 24,
          ));
        }
        questionBrain.nextQuestion();
      }
    });
  }

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
                questionBrain.getQuestionText(),
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
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(userAnswer: true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(userAnswer: false);
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: scorekeeper,
          ),
        )
      ],
    );
  }
}
