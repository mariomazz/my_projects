// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      name: json['name'] as String,
      surname: json['surname'] as String,
      activeSubscription: json['activeSubscription'] as bool,
      subscriptionDate: json['subscriptionDate'] as String,
      placeOfResidence: json['placeOfResidence'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'activeSubscription': instance.activeSubscription,
      'subscriptionDate': instance.subscriptionDate,
      'placeOfResidence': instance.placeOfResidence,
    };
