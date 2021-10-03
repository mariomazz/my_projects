// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      activeSubscription: json['activeSubscription'] as int,
      subscriptionDate: json['subscriptionDate'] as String,
      placeOfResidence: json['placeOfResidence'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'activeSubscription': instance.activeSubscription,
      'subscriptionDate': instance.subscriptionDate,
      'placeOfResidence': instance.placeOfResidence,
    };
