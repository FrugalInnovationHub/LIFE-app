import 'package:flutter/material.dart';
import 'package:passage_flutter/main_pages/learning_page_components/classes.dart';
import 'package:passage_flutter/other_pages/pdf_view_page.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/app_theme.dart';

import 'package:pdfx/pdfx.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  State<LearningPage> createState() => LearningPageState();
}

//global controller. Reassign controller when things change.
PdfController pdfController = PdfController(
    document: PdfDocument.openAsset('assets/module1/module1.1.pdf'));

createController(document) {
  pdfController.loadDocument(document);
  return pdfController;
}

class LearningPageState extends State<LearningPage> {
  //complete list - change order manually. Filtered automatically.
  final _completeList = [
    PdfFile('assets/lessonPdfs/module1/module1.1.pdf', 'Lesson 1.1',
        'This lesson covers the filter', const AppColors().buttonBlue),
    PdfFile('assets/lessonPdfs/module1/module1.2.pdf', 'Lesson 1.2',
        'This lesson covers the filter', const AppColors().buttonBlue),
    PdfFile('assets/lessonPdfs/module1/module1.3.pdf', 'Lesson 1.3',
        'This lesson covers the filter', const AppColors().buttonBlue),
    PdfFile(
        'assets/lessonPdfs/module1/module1.4.pdf',
        'Lesson 1.4 (Bonus Activities)',
        'This lesson covers the filter',
        const AppColors().buttonBlue),
    AdventureObject(
        'Filter Learning Adventure 1',
        'Self-guided lesson, learn about the filter',
        '/scienceLessonOne',
        Colors.green),
    //module 2
    PdfFile('assets/module2/module2.1.pdf', 'Lesson 2.1',
        'This lesson covers the filter', const AppColors().orange),
    PdfFile('assets/lessonPdfs/module2/module2.2.pdf', 'Lesson 2.2',
        'This lesson covers the filter', const AppColors().orange),
    PdfFile('assets/lessonPdfs/module2/module2.3.pdf', 'Lesson 2.3',
        'This lesson covers the filter', const AppColors().orange),
    PdfFile('assets/lessonPdfs/module2/module2.4.pdf', 'Lesson 2.4',
        'This lesson covers the filter', const AppColors().orange),
    PdfFile('assets/lessonPdfs/module2/module2.5.pdf', 'Lesson 2.5 (Bonus)',
        'This lesson covers the filter', const AppColors().orange),
    //module 3
    PdfFile('assets/lessonPdfs/module3/module3.1.pdf', 'Lesson 3.1',
        'This lesson covers the filter', Colors.purple),
    PdfFile('assets/lessonPdfs/module3/module3.2.pdf', 'Lesson 3.2',
        'This lesson covers the filter', Colors.purple),
    PdfFile(
        'assets/lessonPdfs/module3/module3.3.pdf',
        'Lesson 3.3 (Bonus Activities)',
        'This lesson covers the filter',
        Colors.purple),
  ];

  String _dropDownValue = 'All';

  List _filterList() {
    List _list = [];
    //copy over complete list
    _list.addAll(_completeList);
    //if _dropDown value isn't all, then sort the list
    if (_dropDownValue == 'Learning Adventures') {
      _list.retainWhere((element) => element is AdventureObject);
    } else if (_dropDownValue == 'Lesson Modules') {
      _list.retainWhere((element) => element is PdfFile);
    }
    return _list;
  }

  Container _buildLesson(PdfFile fileObject) {
    return Container(
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //willpopscope is used cause popping this page crashes the app - something to fix
              return WillPopScope(
                  onWillPop: () async => false,
                  child: PdfViewPage(
                    controller: PdfController(document: fileObject.document),
                    fileObject: fileObject,
                  )
                  // child: Scaffold(
                  //     appBar: pdfBar(
                  //       context,
                  //       fileObject.title,
                  //     ),
                  //     body: Column(children: [
                  //       Text(fileObject.title),
                  //       Row(children: [
                  //         TextButton(
                  //             onPressed: () {},
                  //             child: Column(children: const [
                  //               Icon(Icons.chevron_left),
                  //               Text('Back')
                  //             ])),
                  //         PdfView(
                  //             controller: PdfController(
                  //                 document: fileObject.document)),
                  //         TextButton(
                  //             onPressed: () {},
                  //             child: Column(children: const [
                  //               Icon(Icons.chevron_right),
                  //               Text('Forwards')
                  //             ])),
                  //       ]),
                  //     ]))
                  );
            }));
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(fileObject.color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ))),
          child: ListTile(
            title: Text(
              fileObject.title,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            subtitle: Text(fileObject.blurb,
                style: const TextStyle(color: Colors.white)),
          ),
        ));
  }

  Container _buildAdventure(AdventureObject adventureObject) {
    return Container(
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
            Navigator.of(context).pushNamed(adventureObject.filePath);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(adventureObject.color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ))),
          child: ListTile(
            title: Text(
              adventureObject.title,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            subtitle: Text(
              adventureObject.blurb,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
                child: Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Learning',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  const SizedBox(height: 4),
                  const Text('Choose a topic to learn'),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const AppColors().lightBlue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      value: _dropDownValue,
                      icon: Icon(
                        Icons.expand_more,
                        color: const AppColors().buttonBlue,
                      ),
                      underline: const SizedBox(),
                      elevation: 0,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropDownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'All',
                        'Learning Adventures',
                        'Lesson Modules'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // move single child scroll view here if you want just the lessons to scroll
                  SizedBox(
                      width: 910,
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: _filterList()
                            .map((object) => object is AdventureObject
                                ? _buildAdventure(object)
                                : (object is PdfFile)
                                    ? _buildLesson(object)
                                    : const SizedBox())
                            .toList(),
                      ))
                ])))));
  }
}

AppBar pdfBar(context, String title) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 40,
      color: AppTheme.colors.darkBlue,
      onPressed: () {
        pdfController.dispose();
        //if pop until is used then it tries to pop the pdf page which is a poroblem.
        //I think it's cause it disposes of the pdf viewer
        //Either way just have it push the home page instead of popping until.
        Navigator.pushNamed(context, '/', arguments: 2);
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    ),
    centerTitle: true,
    backgroundColor: AppTheme.colors.lightBlue,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    toolbarHeight: 50,
  );
}
