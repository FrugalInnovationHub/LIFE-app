import 'package:json_annotation/json_annotation.dart';

/*
Automatically generates companion file, data_class.g.

Run this to generate new companion file, necessary if you change this file:
  flutter pub run build_runner build --delete-conflicting-outputs 

Reference: https://flutter.dev/docs/development/data-and-backend/json#serializing-json-using-code-generation-libraries
*/
part 'data_class.g.dart';

@JsonSerializable()
class DataClass {
  List<int> trophies;
  //set mostRecent to 100 when no trophies have been found
  int mostRecent;
  //Initials defaults to 'AA'. When a trophy is found the user can enter their initials
  List<String> initials;

  DataClass(
      {required this.trophies,
      required this.mostRecent,
      required this.initials});

  //use this to get one property
  int get(int index) {
    return trophies[index];
  }

  factory DataClass.fromJson(Map<String, dynamic> json) =>
      _$DataClassFromJson(json);

  Map<String, dynamic> toJson() => _$DataClassToJson(this);
}
