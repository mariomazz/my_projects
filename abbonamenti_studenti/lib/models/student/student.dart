import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  String name;
  String surname;
  bool activeSubscription;
  String subscriptionDate;
  String placeOfResidence;

  Student({
    required this.name,
    required this.surname,
    required this.activeSubscription,
    required this.subscriptionDate,
    required this.placeOfResidence,
  });
}
