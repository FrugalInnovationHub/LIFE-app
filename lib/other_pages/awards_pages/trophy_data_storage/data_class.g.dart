// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataClass _$DataClassFromJson(Map<String, dynamic> json) => DataClass(
      trophies:
          (json['trophies'] as List<dynamic>).map((e) => e as int).toList(),
      mostRecent: json['mostRecent'] as int,
      initials:
          (json['initials'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DataClassToJson(DataClass instance) => <String, dynamic>{
      'trophies': instance.trophies,
      'mostRecent': instance.mostRecent,
      'initials': instance.initials,
    };
