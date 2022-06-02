import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passage_flutter/other_pages/awards_pages/trophy_data_storage/trophy_progress_model.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../data_storage/learning_progress_model.dart';
import 'dart:developer';
import 'dart:math' hide log; //using log for development

/*Quiz Component. Used in lesson modules. Requires many parameters, including a defined height.
Defined height is because the lesson needs to know height to calculate progress made. 

Made by Daniel MS
*/

class QuizComponent extends StatefulWidget {
  final List questions;
  final List allAnswers;
  final List correctAnswers;
  final int numQuizzes;
  final bool finalQuiz;
  final Function clearProgress;
  final String quizName;
  final Function submitQuiz;

  //index starts at 0!!!
  final int index;
  final String lessonName;

  const QuizComponent(
      {Key? key,
      required this.clearProgress,
      required this.quizName,
      required this.finalQuiz,
      required this.questions,
      required this.allAnswers,
      required this.correctAnswers,
      required this.numQuizzes,
      required this.index,
      required this.lessonName,
      required this.submitQuiz})
      : super(key: key);

  @override
  State<QuizComponent> createState() => _QuizComponentState();
}

class _QuizComponentState extends State<QuizComponent> {
  //internal state - initialized as a list of 'numQuizzes'  entries.
  late List<int> _progressData;
  //
  late final int numQuestions;

  //Add the index of the answer they choose to this
  //Selected answers is initialized to all have a value of 100: [100, 100];
  //If they choose the answer w/ index 0 then add a 0 to it.
  //If it's fill in the blank, give a 100 if it's wrong, and a 99 if it's right
  //it's wrong
  late List<int> _selectedAnswers;
  late List<String> _selectedStringAnswers;

  bool _quizFinished = false;

  void submit() {
    log('submitting..');
    for (int i = 0; i < numQuestions; i++) {
      if (_selectedStringAnswers[i] != widget.correctAnswers[i]) {
        return;
      }
    }
    //We got to the end so all answers were correct
    setState(() {
      _quizFinished = true;
    });
    log('submitted successfully');

    //check if last quiz
    if (widget.finalQuiz) {
      //trophy generation & saving
      int _trophyIndex = generateTrophy();
      Provider.of<TrophyProgressStore>(context, listen: false)
          .addTrophy(_trophyIndex);
      Provider.of<TrophyProgressStore>(context, listen: false)
          .changeMostRecent(_trophyIndex);
      _quizFinished = false;
      widget.submitQuiz;
      _selectedAnswers = List.filled(_selectedAnswers.length, 0);
      //sleep command necessary for clearProgress to run
      sleep(const Duration(milliseconds: 100));
      Navigator.pushNamed(context, '/finishPage', arguments: _trophyIndex);
    } else {
      Provider.of<LearningProgressStore>(context, listen: false)
          .changeProgress(widget.lessonName, widget.index, 1);
      log(Provider.of<LearningProgressStore>(context, listen: false)
          .getProgressData()
          .toString());
    }
  }

  int generateTrophy() {
    Random _random = Random();
    int _number = _random.nextInt(49);

    Provider.of<TrophyProgressStore>(context, listen: false).addTrophy(_number);
    return _number;
  }

  List<Widget> _createQuestions() {
    List<Widget> questions = [];
    List<Widget> answers = [];
    for (int i = 0; i < numQuestions; i++) {
      int length = widget.allAnswers[i].length;
      //if length == 1 then it's a fill in the blank
      if (length == 1) {
        questions.add(Column(children: [
          Text(widget.questions[i]),
        ]));
      } else {
        answers = []; //start w/ blank answers then fill them in
        for (int j = 0; j < widget.allAnswers[i].length; j++) {
          answers.add(RadioListTile<String>(
              title: Text(widget.allAnswers[i][j]),
              value: widget.allAnswers[i][j],
              groupValue: _selectedStringAnswers[i],
              onChanged: (String? value) {
                setState(() {
                  _selectedStringAnswers[i] = value!;
                });
              }));
        }
        //at the end of each iteration of i add the question as well
        questions.add(
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text((i + 1).toString() + '). ' + widget.questions[i]),
          ...answers,
          const SizedBox(height: 10),
        ]));
      }
    }
    return questions;
  }

  @override
  void initState() {
    super.initState();
    numQuestions = widget.questions.length;
    _selectedAnswers = List.filled(numQuestions, 100);
    _selectedStringAnswers = List.filled(numQuestions, '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _storage = Provider.of<LearningProgressStore>(context);

    setState(() {
      //get() is the mapped version. Idk why I'm using it here I forget
      _selectedAnswers = _storage.getProgressData().get(widget.lessonName);
      _progressData = _storage.getProgressData().get(widget.lessonName);
      _quizFinished = _selectedAnswers[widget.index] == 1;
      log('_progressData changed to: $_progressData');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            border: Border.all(
              color: const AppColors().buttonBlue,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(widget.quizName),
            Text('Quiz #' + (widget.index + 1).toString()),
            _quizFinished
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: _createQuestions(),
                    ),
                  ),
            _quizFinished
                ? const Text('Finished')
                : TextButton(
                    onPressed: submit, child: const Text('Submit Quiz')),
          ],
        ));
  }
}
