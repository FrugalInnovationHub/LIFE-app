import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'package:passage_flutter/other_pages/awards_pages/trophy_data_storage/trophy_progress_model.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => FinishPageState();
}

class FinishPageState extends State<FinishPage> {
  int _trophyIndex = 100;
  final TextEditingController _controller = TextEditingController(text: "");
  bool _showError = false;
  bool _submitting = false;
  //default is AA I guess
  String _initials = 'AA';
  late bool _valid;

  static final RegExp nameReg = RegExp('[a-zA-Z]');

  @override
  Widget build(BuildContext context) {
    //argument passed is index of trophy got by user. 100 is default.
    _trophyIndex = ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as int
        : 100;

    //if valid then they just completed a lesson. If not valid, remove the ability to add initials

    _valid = _trophyIndex != 100;
    return Scaffold(
      appBar: secondaryAppBar(context, 'Lesson Complete'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _valid ? const Text('Congratulations!') : Container(),
                  _valid
                      ? Text(
                          'You discovered ${Provider.of<TrophyProgressStore>(context, listen: true).getTrophyData().mostRecent.toString()} (most recent)')
                      : Container(),
                  const SizedBox(height: 20),
                  Text(_trophyIndex == 100
                      ? 'No Trophy to display'
                      : 'Your trophy is $_trophyIndex'),
                  const SizedBox(height: 20),
                  _valid ? const Text("Enter your initials!") : Container(),
                  _valid
                      ? const SizedBox(
                          height: 20,
                        )
                      : Container(),
                  _valid
                      ? Row(children: [
                          PinCodeTextField(
                            autofocus: false,
                            controller: _controller,
                            hideCharacter: false,
                            highlight: true,
                            highlightColor: Colors.blue,
                            defaultBorderColor: Colors.black,
                            maxLength: 2,
                            onTextChanged: (text) {
                              _initials = text;
                            },
                            onDone: (text) {
                              _initials = text;
                              log('done, text: $text');
                            },
                            pinBoxWidth: 50,
                            pinBoxHeight: 64,
                            hasUnderline: true,
                            wrapAlignment: WrapAlignment.spaceAround,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .defaultPinBoxDecoration,
                            pinTextStyle: const TextStyle(fontSize: 22.0),
                            pinTextAnimatedSwitcherTransition:
                                ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                            pinTextAnimatedSwitcherDuration:
                                const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            keyboardType: TextInputType.name,
                          ),
                          _submitting
                              ? FittedBox(
                                  child: Container(
                                      margin: const EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppTheme.colors.darkBlue))))
                              : Container(),
                          TextButton(
                              onPressed: _submitting
                                  ? null
                                  : () {
                                      setState(() {
                                        _submitting = true;
                                      });
                                      sleep(const Duration(milliseconds: 700));
                                      setState(() {
                                        _submitting = false;
                                      });
                                      if (nameReg.hasMatch(_initials) &&
                                          _initials.length == 2) {
                                        Provider.of<TrophyProgressStore>(
                                                context,
                                                listen: false)
                                            .changeInitials(
                                                _trophyIndex, _initials);
                                        _controller.clear();
                                      } else {
                                        _controller.clear();
                                        _showError = true;
                                      }
                                    },
                              child: const Text("Submit Initials"))
                        ])
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 20,
                      child: _showError
                          ? const Text(
                              'Please enter only letters',
                              style: TextStyle(color: Colors.red),
                            )
                          : Container()),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () => {
                                //sends homepage so that the back button on trophy room page takes the user home
                                Navigator.pushNamed(context, '/'),
                                Navigator.pushNamed(context, '/trophyRoom')
                              },
                          child: const Text(
                              'Check out your item in the Trophy Room')),
                      TextButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: const Text('Go back to learning adventures'))
                    ],
                  ),
                ],
              ))),
    );
  }
}
