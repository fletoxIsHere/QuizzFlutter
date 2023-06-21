import 'package:quizz/question.dart';

class AppBrain {
  int _questionNumber = 0;

  final List<Question> _questionGroup = [
    Question(
        q: 'They are 8 planets in the solar group.',
        i: 'images/image-1.jpg',
        a: true),
    Question(q: 'cats eat meat.', i: 'images/image-2.jpg', a: true),
    Question(
        q: 'china is located in africa.', i: 'images/image-3.jpg', a: false),
    Question(q: 'the earth is flat.', i: 'images/image-4.jpg', a: false),
    Question(
        q: 'humans can live without meat.', i: 'images/image-5.jpg', a: true),
    Question(
        q: 'the sun turn around the earth and the earth turn around the moon.',
        i: 'images/image-6.jpg',
        a: false),
    Question(q: 'Animals doesnt feel pain.', i: 'images/image-7.jpg', a: false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionGroup.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionGroup[_questionNumber].questionText;
  }

  String getQuestionImage() {
    return _questionGroup[_questionNumber].questionImage;
  }

  bool getQuestionAnswer() {
    return _questionGroup[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionGroup.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  int countQuestions() {
    return _questionGroup.length;
  }

  void reset() {
    _questionNumber = 0;
  }
}
