import 'package:hive/hive.dart';

part 'db_helper.g.dart';

@HiveType(typeId: 0)
class UserLoginDetails {
  @HiveField(0)
  final String? userName;
  @HiveField(1)
  final String? password;

  UserLoginDetails({this.userName, this.password});
}

@HiveType(typeId: 1)
class UserExamDetails {
  @HiveField(0)
  final int? userId;
  @HiveField(1)
  final String? registeringUserName;
  @HiveField(2)
  final String? age;
  @HiveField(3)
  final String? gender;
  @HiveField(4)
  final String? seatPosition;


  UserExamDetails(
      {this.seatPosition,this.userId, this.registeringUserName, this.age, this.gender});
}
