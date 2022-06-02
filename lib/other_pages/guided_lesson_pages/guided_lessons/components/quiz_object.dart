class QuizJson {
  // required List questions,
  // required List allAnswers,
  // required List correctAnswers

  List<String> questions;
  List<List> allAnswers;
  List<String> correctAnswers;

  QuizJson(this.questions, this.allAnswers, this.correctAnswers);
}
