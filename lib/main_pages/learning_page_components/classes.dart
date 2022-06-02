import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfFile {
  String filePath;
  String title;
  String blurb;
  Color color;
  late final document = PdfDocument.openAsset(filePath);

  PdfFile(this.filePath, this.title, this.blurb, this.color);
}

class AdventureObject {
  String title;
  String blurb;
  String filePath;
  Color color;

  AdventureObject(this.title, this.blurb, this.filePath, this.color);
}
