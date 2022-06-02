// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easy_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EasyData _$EasyDataFromJson(Map<String, dynamic> json) => EasyData(
      mathOne: (json['mathOne'] as List<dynamic>).map((e) => e as int).toList(),
      scienceOne:
          (json['scienceOne'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$EasyDataToJson(EasyData instance) => <String, dynamic>{
      'mathOne': instance.mathOne,
      'scienceOne': instance.scienceOne,
    };
