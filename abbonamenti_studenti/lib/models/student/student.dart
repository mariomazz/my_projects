import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
@Entity(tableName: 'Student')
class Student {
  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @PrimaryKey(autoGenerate: true)
  int id;
  String name;
  String surname;
  int activeSubscription;
  String subscriptionDate;
  String placeOfResidence;

  Student({
    required this.id,
    required this.name,
    required this.surname,
    required this.activeSubscription,
    required this.subscriptionDate,
    required this.placeOfResidence,
  });
}
