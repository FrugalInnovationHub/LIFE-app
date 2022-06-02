import 'package:flutter/material.dart';
import 'package:passage_flutter/components/tita_text_bar.dart';
import 'package:passage_flutter/other_pages/awards_pages/trophy_data_storage/trophy_progress_model.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/components/outlined_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Home',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                      SizedBox(height: 4),
                      Text('All your modules')
                    ]),
                TitaTextBar(
                    height: 60,
                    length: 300,
                    happyBool: true,
                    text:
                        'I\'m tita! I provide you with helpful tips and information ')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 290,
                      height: 286,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const AppColors().lightBlue,
                                width: 3,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.all(10),
                          child: Center(
                              child: Column(children: [
                            const Text('Dive back in'),
                            const SizedBox(height: 20),
                            Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const AppColors().shadowColor,
                                      offset: const Offset(6, 6),
                                      blurRadius: 12,
                                      spreadRadius: 3,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                height: 100,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/', arguments: 2);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const AppColors().buttonBlue),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ))),
                                    child: const Center(
                                        child: Text(
                                      'Lesson 1',
                                      style: TextStyle(color: Colors.white),
                                    )))),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const AppColors().lightBlue,
                                    width: 3,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 20,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  color: const AppColors().buttonBlue,
                                  value: 0.7,
                                ),
                              ),
                            ),
                            // const SizedBox(height: 10),
                            const Text('35%')
                          ])))),
                  const SizedBox(width: 20),
                  SizedBox(
                      width: 290,
                      height: 286,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const AppColors().lightBlue,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/trophyRoom');
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: Column(children: [
                                    const Text('Congrats'),
                                    const SizedBox(height: 10),
                                    const Icon(
                                      Icons.lightbulb,
                                      size: 100,
                                    ),
                                    const SizedBox(height: 10),
                                    Consumer<TrophyProgressStore>(
                                      //show no trophies found it no trophies found,
                                      //otherwise show most recent trophy found
                                      builder: (context, store, child) {
                                        int index =
                                            store.getTrophyData().mostRecent;
                                        Widget widget = (index == 100)
                                            ? const Text(
                                                "No Trophies found yet")
                                            : Text(
                                                "${store.getTrophyData().initials[index]} found trophy $index");
                                        return widget;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                  ])))))),
                  const SizedBox(width: 20),
                  SizedBox(
                      width: 290,
                      child: Column(
                        children: [
                          const Text('Extras',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 24)),
                          const SizedBox(height: 24),
                          outlinedButton(
                            context,
                            text: 'Meet the Students',
                            path: '/teacherResources',
                            height: 105,
                          ),
                          const SizedBox(height: 20),
                          Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const AppColors().shadowColor,
                                    offset: const Offset(6, 6),
                                    blurRadius: 12,
                                    spreadRadius: 3,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              height: 105,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/teacherResources');
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const AppColors().orange),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ))),
                                  child: const Center(
                                      child: Text(
                                    'Teacher Resources',
                                    style: TextStyle(color: Colors.white),
                                  ))))
                        ],
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

//OBSOLETE NOW
class MeetTheStudents extends StatelessWidget {
  const MeetTheStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Hi, Welcome to your L.I.F.E. tablet & accompanying water filter! You\'re currently on the home page. Click on the buttons down below to go to the filter on the right, and the learning lessons, on the left.',
                style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 100,
            ),
            TitaTextBar(
                height: 100,
                length: 400,
                happyBool: true,
                text:
                    'LIFE stands for LATAM Filter for Education and is a university project made by 5 engineering and 4 public health students! ')
          ],
        ));
  }
}
