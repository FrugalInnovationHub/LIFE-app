import 'package:flutter/material.dart';

import 'dart:developer';

import 'components/guided_app_bar.dart';

import 'components/quiz_component.dart';
import '../data_storage/learning_progress_model.dart';
import 'package:provider/provider.dart';
import 'components/quiz_object.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//Define all the quiz objects here - they won't change

final quizOneJson = QuizJson([
  "Which filter is faster but lets more particles through?"
], [
  ["Gravel", "Sand"]
], [
  "Gravel"
]);

final quizTwoJson = QuizJson([
  "what's 2+2",
  "What's 3+3"
], [
  ["4", "5", "6"],
  ["4", "7", "6"]
], [
  "4",
  "6"
]);

//define where quiz objects are in the page(their index, starting at 0). Necessary
//for scrollto
final List whereAreQuizzes = [10, 13];

//Begin science lesson widget
class ScienceLesson extends StatefulWidget {
  const ScienceLesson({Key? key}) : super(key: key);

  @override
  State<ScienceLesson> createState() => ScienceLessonState();
}

class ScienceLessonState extends State<ScienceLesson> {
  final ItemScrollController _scrollController = ItemScrollController();

  //what the current progress is set to
  double _currentProgress = 0;

  late List _progressArray;

  int numQuizzes = 2;

  //used for last quiz
  void submitQuiz() {
    _scrollController.jumpTo(
      index: 0,
    );
    setState(() {
      _currentProgress = 0;
      _progressArray = List.filled(_progressArray.length, 0);
    });
    Provider.of<LearningProgressStore>(context, listen: false)
        .clearProgress('scienceOne');
  }

  void clearProgress() {
    _scrollController.scrollTo(
      index: 0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentProgress = 0;
      _progressArray = List.filled(_progressArray.length, 0);
    });
    Provider.of<LearningProgressStore>(context, listen: false)
        .clearProgress('scienceOne');
  }

  //In didChangeDependencies context is bound so we can use Provider.of(context)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _progressArray = Provider.of<LearningProgressStore>(context)
          .getProgressData()
          .scienceOne;

      _currentProgress = _progressArray.fold(0, (t, c) => t + c);
      _currentProgress *= 100 / _progressArray.length;
    });

    log('_currentProgress changed to: $_progressArray');
  }

  Widget _myList(int index) {
    List list = [
      const Text(
          "Ok kids, let's learn about the filters at work in our filtration system. We have sand, gravel, and charcoal. Sand is really small rocks. When pieces of dirt or other contaminants go through the sand filter these particles get stuck in the sand, and filtered out. "),
      const SizedBox(height: 20),
      const Text(
          "Learning Note!: A particle is what we call a small piece of something. "),
      const SizedBox(height: 20),
      const Text(
          "The gravel filter also helps the sand filter in removing small particles that we don’t want to be drinking! Gravel is big rocks. Think for a second about why we use gravel and sand. "),
      const SizedBox(height: 20),
      const Text(
          "The reason is that one filters faster than the other, but doesn’t do as good a job filtering particles out. Can you make a hypothesis about which one is which?"),
      const SizedBox(height: 20),
      const Text(
          "Learning Note!: A hypothesis is an educated guess. It’s using your knowledge and past experience to make a guess."),
      const SizedBox(height: 20),
      QuizComponent(
        quizName: 'Learning Check',
        clearProgress: clearProgress,
        questions: quizOneJson.questions,
        allAnswers: quizOneJson.allAnswers,
        correctAnswers: quizOneJson.correctAnswers,
        numQuizzes: numQuizzes,
        index: 0,
        lessonName: 'scienceOne',
        finalQuiz: false,
        submitQuiz: submitQuiz,
      ),
      const SizedBox(
        height: 200,
      ),
      const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan libero a lacinia fermentum. Mauris ac tellus et ante fringilla faucibus. Quisque hendrerit odio non magna posuere, sed accumsan nisi rutrum. Suspendisse quis tempor magna. Nullam velit elit, lobortis elementum molestie et, hendrerit ultricies magna. Etiam est leo, bibendum nec feugiat sed, varius in sem. Morbi imperdiet gravida libero, euismod eleifend nisl interdum ut. In nec est turpis. Duis commodo turpis nulla, at tempor felis vehicula nec. Nulla libero velit, mollis ac risus ac, fringilla luctus urna. Integer dapibus efficitur facilisis. Nullam malesuada turpis et lorem vehicula varius. Aliquam luctus, nisi sed dictum vulputate, risus nulla tempor felis, sit amet mattis ante purus quis enim. Fusce malesuada et orci non ullamcorper. Vivamus vel urna ipsum. Praesent eget vestibulum justo. Aenean luctus risus dui, lobortis dapibus nisl vulputate nec. Cras iaculis neque eget porta lobortis. Etiam in mi at dui finibus venenatis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas varius metus eu ipsum pretium molestie nec et ante. Aliquam pharetra metus in ornare tincidunt. Donec bibendum efficitur purus sit amet pretium. Nam quis bibendum sapien. Aenean fermentum venenatis felis, in tristique turpis imperdiet vitae. Sed venenatis pretium elementum. Morbi vehicula convallis laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla fringilla suscipit est, eu lobortis ex faucibus sed. Curabitur nisi nulla, consectetur et dignissim euismod, porttitor efficitur purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam congue, nulla sed sollicitudin posuere, ipsum velit tempus mi, sed fermentum dolor tellus quis sem. In sagittis nisl non quam blandit feugiat. Mauris a ex eu nibh vestibulum ornare sed nec massa. Praesent rutrum mollis tortor. Aenean urna erat, semper eu lorem ut, sollicitudin condimentum massa. Donec mollis eros vitae nunc consectetur, at pretium ante varius. Aliquam nec varius dolor. Mauris sollicitudin tortor sed magna pellentesque molestie. Proin enim urna, maximus eu imperdiet non, vehicula sit amet quam. Sed feugiat, ligula ac feugiat venenatis, nisl arcu accumsan mauris, non lobortis velit dui sit amet diam. Cras eget turpis placerat, euismod ex at, condimentum sapien. Nam scelerisque viverra lorem, molestie finibus erat auctor vitae. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam fringilla molestie nulla eget suscipit. Aliquam sit amet leo dui. Pellentesque laoreet turpis vitae urna bibendum, non accumsan nunc tristique. Mauris at ipsum sit amet ipsum laoreet venenatis. Donec id orci vel ante ultrices varius at id urna. Nulla aliquam est sed diam sagittis, in facilisis est fermentum. Etiam luctus bibendum diam, id ultrices lacus ornare vitae.'),
      QuizComponent(
        quizName: 'Test Quiz',
        clearProgress: clearProgress,
        questions: quizTwoJson.questions,
        allAnswers: quizTwoJson.allAnswers,
        correctAnswers: quizTwoJson.correctAnswers,
        numQuizzes: numQuizzes,
        index: 1,
        lessonName: 'scienceOne',
        finalQuiz: true,
        submitQuiz: submitQuiz,
      ),
    ];

    //this is used because ScrollablePositionedList has to use a builder file.
    return list[index];
  }

  void scrollToCurrent() {
    for (int i = 0; i < numQuizzes; i++) {
      if (_progressArray[i] == 0) {
        _scrollController.scrollTo(
            index: whereAreQuizzes[i],
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn);
        //don't scroll again
        return;
      }
    }
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: guidedAppBar(context, 'Science Lesson One', scrollToCurrent,
            _scrollController, _currentProgress.toInt(), clearProgress),
        body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: ScrollablePositionedList.builder(
              shrinkWrap: true,
              itemScrollController: _scrollController,
              itemBuilder: (context, index) => _myList(index),
              itemCount: 14,
            )));
  }
}
