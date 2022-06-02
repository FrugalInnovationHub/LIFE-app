import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/components/outlined_button.dart';

class TeacherResources extends StatefulWidget {
  const TeacherResources({Key? key}) : super(key: key);

  @override
  State<TeacherResources> createState() => TeacherState();
}

class TeacherState extends State<TeacherResources> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: secondaryAppBar(context, 'Teacher Resources'),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Teacher Resources',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20)),
                        SizedBox(height: 4),
                        Text('Teacher Guides, experiment worksheets, and more')
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Text('Help',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20)),
                            const SizedBox(height: 32),
                            outlinedButton(context,
                                text: 'Teacher Guide (tbd)',
                                path: '/',
                                blue: false),
                            const SizedBox(height: 20),
                            outlinedButton(context,
                                text: 'Admin Page',
                                path: '/checkPage',
                                blue: false)
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const Text('Filter',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20)),
                            const SizedBox(height: 32),
                            outlinedButton(context,
                                text: 'Refill Filters (tbd)',
                                path: '/',
                                blue: false),
                            const SizedBox(height: 20),
                            outlinedButton(context,
                                text: 'FAQ (tbd)', path: '/', blue: false)
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const Text('Instructions',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20)),
                            const SizedBox(height: 32),
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
                                width: 290,
                                height: 120,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/');
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const AppColors().orange),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ))),
                                    child: const Center(
                                        child: Text(
                                      'Teacher Guides (tbd)',
                                      style: TextStyle(color: Colors.white),
                                    )))),
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
                                width: 290,
                                height: 120,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/');
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const AppColors().orange),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ))),
                                    child: const Center(
                                        child: Text(
                                      'Extra Resources (tbd)',
                                      style: TextStyle(color: Colors.white),
                                    ))))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
