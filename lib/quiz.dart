import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question_bank.dart';
import 'package:audioplayers/audioplayers.dart';

QuestionBank bank = QuestionBank();


class Quiz extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:10),
            child: QuizPage(),
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
  final player = AudioPlayer();

  void checkAnswer(bool pickedAnswer){
    bool correctAnswer = bank.getCorrectAnswer();

    setState(() {
      if(bank.isFinished()){
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You have reached the end of the quiz.',
        ).show();
        String title = "";
        String desc = "";
        if(bank.correct >= bank.wrong) {
          title = 'Congratulations!';
          desc = 'Bravo you passed the quiz\n'+'Your final score is\n'+'Correct : '+bank.correct.toString()+'\n'+'Wrong : '+bank.wrong.toString();
          player.play(AssetSource('audios/winner.mp3'));
        }
        else{
          title = 'Oh no!';
          desc = 'You failed the quiz\n'+'Your final score is\n'+'Correct : '+bank.correct.toString()+'\n'+'Wrong : '+bank.wrong.toString();
          player.play(AssetSource('audios/looser.mp3'));
        }
        Alert(
          context: context,
          title: title,
          desc: desc,
        ).show();
        bank.reset();
        scoreKeeper = [];
      }

      else{
        if(pickedAnswer == correctAnswer){
          player.play(AssetSource('audios/correct.wav'));
          bank.correct++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          Alert(
            context: context,
            title: 'Correct',
            desc: 'Your score now is\n'+'Correct : '+bank.correct.toString()+'\n'+'Wrong : '+bank.wrong.toString(),
          ).show();
        }
        else{
          player.play(AssetSource('audios/wrong.mp3'));
          bank.wrong++;
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          Alert(
            context: context,
            title: 'Wrong!',
            desc: 'Your score now is\n'+'Correct : '+bank.correct.toString()+'\n'+'Wrong : '+bank.wrong.toString(),
          ).show();
        }
        bank.nextQuestion();
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
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                bank.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              // textColor: Colors.white,
              // color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

}

