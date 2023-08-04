import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question_bank.dart';

QuestionBank bank = QuestionBank();

void main() {
  runApp(Quiz());
}

class Quiz extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizPageState();
  }
}

class QuizPageState extends State<QuizPage>{

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool pickedAnswer){
    bool correctAnswer = bank.getCorrectAnswer();

    setState(() {
      if(bank.isFinished()){
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You have reached the end of the quiz.',
        ).show();
        bank.reset();
        scoreKeeper = [];
      }

      else{
        if(pickedAnswer == correctAnswer){
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        }
        else{
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        bank.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

