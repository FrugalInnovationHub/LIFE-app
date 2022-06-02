import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

//If the svg isn't working follow this:
//https://stackoverflow.com/questions/61202925/svgpicture-image-rendering-error-in-flutter

class TitaTextBar extends StatelessWidget {
  final String text;
  final int length;
  final int height;
  final bool happyBool;

  TitaTextBar(
      {Key? key,
      required this.height,
      required this.length,
      required this.happyBool,
      required this.text})
      : super(key: key);

  final Widget titaSvg = SvgPicture.asset('assets/tita.svg');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: length.toDouble(),
        height: height.toDouble(),
        child: Stack(children: [
          //const SizedBox(height: 100),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(text),
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: const AppColors().lightBlue, width: 4),
                borderRadius: BorderRadius.circular(5)),
          ),
          //const SizedBox(height: 100),
          Positioned(
              right: 10,
              top: 10,
              child: SizedBox(
                  height: 50,
                  width: 30,
                  child: OverflowBox(
                    child: titaSvg,
                    maxHeight: 150,
                    maxWidth: 150,
                  ))),
        ]));
  }
}
