import 'question.dart';

class QuestionBrain {
  // Properties
  int _currentQuestion = 0;
  List<Question> _listQuestions = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
  ];

  // Public methods
  String getCurrentQuestion() {
    return _listQuestions[_currentQuestion].question;
  }

  bool isCorrectAnswer(bool userAnswer) {
    print('$_currentQuestion');
    return _listQuestions[_currentQuestion].answer == userAnswer;
  }

  bool isLastQuestion() {
    return _currentQuestion >= _listQuestions.length - 1;
  }

  void nextQuestion() {
    _currentQuestion++;
  }

  void resetQuestions() {
    _currentQuestion = 0;
  }

  List<Question> listQuestions() {
    return _listQuestions;
  }
}
