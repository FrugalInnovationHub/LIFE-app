import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => CheckPageState();
}

class CheckPageState extends State<CheckPage> {
  String _text = '';
  final TextEditingController _controller = TextEditingController(text: "");
  bool _wrong = false;
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'Admin Page'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text('Enter in your admin password'),
                  Text(_text),
                  Row(
                    children: [
                      const SizedBox(width: 300),
                      PinCodeTextField(
                        autofocus: true,
                        controller: _controller,
                        hideCharacter: true,
                        highlight: true,
                        highlightColor: Colors.blue,
                        defaultBorderColor: Colors.black,
                        hasTextBorderColor: Colors.green,
                        maxLength: 4,
                        maskCharacter: "*",
                        onTextChanged: (text) {
                          setState(() {
                            _text = text;
                          });
                        },
                        onDone: (text) {
                          setState(() {
                            _submitting = true;
                          });
                          //sleep call to simulate backend stuff happening
                          sleep(const Duration(milliseconds: 700));
                          setState(() {
                            _submitting = false;
                          });
                          if (text == "1234") {
                            log("Correct");
                            _controller.clear();
                            Navigator.pushNamed(context, '/adminPage');
                          } else {
                            _controller.clear();
                            _wrong = true;
                          }
                        },
                        pinBoxWidth: 50,
                        pinBoxHeight: 64,
                        hasUnderline: true,
                        wrapAlignment: WrapAlignment.spaceAround,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: const TextStyle(fontSize: 22.0),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                        pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.white12,
                        keyboardType: TextInputType.number,
                      ),
                      _submitting
                          ? FittedBox(
                              child: Container(
                                  margin: const EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppTheme.colors.darkBlue))))
                          : Container(/* Dummy */),
                    ],
                  ),
                  _wrong
                      ? const Text(
                          "Wrong password, try again",
                          style: TextStyle(color: Colors.red),
                        )
                      : const Text(""),
                ],
              ))),
    );
  }
}
