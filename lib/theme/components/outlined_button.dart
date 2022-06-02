import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_colors.dart';

Widget outlinedButton(BuildContext context,
    //default values:
    {required String text,
    required String path,
    double borderRadius = 20,
    double width = 290,
    double height = 120,
    bool blue = true}) {
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
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.white,
    ),
    child: Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(path);
          },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: blue
                      ? const AppColors().buttonBlue
                      : const AppColors().orange,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Text(
                text,
                style: TextStyle(
                    color: blue
                        ? const AppColors().buttonBlue
                        : const AppColors().orange),
              )))),
    ),
  );
}
