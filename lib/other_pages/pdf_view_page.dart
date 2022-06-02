import 'package:flutter/material.dart';
import 'package:passage_flutter/main_pages/learning_page_components/classes.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewPage extends StatefulWidget {
  final PdfController controller;
  final PdfFile fileObject;

  const PdfViewPage(
      {Key? key, required this.controller, required this.fileObject})
      : super(key: key);

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: pdfBar(context, widget.fileObject.title, widget.controller),
        body: Column(children: [
          Text(widget.fileObject.title),
          Row(children: [
            TextButton(
                onPressed: () {
                  widget.controller.page == 0
                      ? null
                      : widget.controller.animateToPage(
                          widget.controller.page - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                },
                child: Column(
                    children: const [Icon(Icons.chevron_left), Text('Back')])),
            SizedBox(
                height: 400,
                width: 800,
                child: PdfView(controller: widget.controller)),
            TextButton(
                onPressed: () {
                  widget.controller.page ==
                          (widget.controller.pagesCount?.toDouble() ?? 0)
                      ? null
                      : widget.controller.animateToPage(
                          widget.controller.page + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                },
                child: Column(
                    children: const [Icon(Icons.chevron_right), Text('Next')])),
          ]),
          const SizedBox(height: 20),
          Slider(
              //if null whole expression returns null [?] which returns 0 [??].
              max: widget.controller.pagesCount?.toDouble() ?? 0,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
                widget.controller.jumpToPage(value.toInt());
              },
              value: _sliderValue),
          const SizedBox(height: 20),
          Text(_sliderValue.toString()),
        ]));
  }
}

AppBar pdfBar(context, String title, PdfController controller) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 40,
      color: AppTheme.colors.darkBlue,
      onPressed: () {
        controller.dispose();
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
