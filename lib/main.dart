import 'package:flutter/material.dart';
import 'QuestionBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  List<Icon> listScored = [];
  QuestionBrain questionBrain = QuestionBrain();

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
                questionBrain.getCurrentQuestion(),
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
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  TextStyle(color: Colors.white),
                ),
                backgroundColor: WidgetStateProperty.all(
                  Colors.green,
                ),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  TextStyle(color: Colors.white),
                ),
                backgroundColor: WidgetStateProperty.all(
                  Colors.red,
                ),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleAnswer(false);
              },
            ),
          ),
        ),
        Wrap(
          children: listScored,
        ),
      ],
    );
  }

  void handleAnswer(bool userAnswer) {
    setState(() {
      if (!(questionBrain.listQuestions().length == listScored.length)) {
        Icon score = questionBrain.isCorrectAnswer(userAnswer)
            ? Icon(Icons.check, color: Colors.green)
            : Icon(Icons.close, color: Colors.red);
        listScored.add(score);
      }
      if (questionBrain.isLastQuestion()) {
        showAlert();
      } else {
        questionBrain.nextQuestion();
      }
    });
  }

  Future<void> showAlert() async {
    await Alert(
      context: super.context,
      title: "THÔNG BÁO",
      desc: 'Bạn dã hoàn thiện hết số lượng câu hỏi. Chúc mừng bạn !!',
      buttons: [
        DialogButton(
          child: Text('OK'),
          onPressed: () {
            setState(() {
              questionBrain.resetQuestions();
              listScored = [];
              Navigator.of(context).pop();
            });
          },
        )
      ],
    ).show();
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
