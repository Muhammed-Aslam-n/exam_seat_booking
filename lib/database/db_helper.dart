import 'package:hive/hive.dart';
part 'db_helper.g.dart';


@HiveType(typeId:0)
class UserLoginDetails{
  @HiveField(0)
  final String? userName;
  @HiveField(1)
  final String? password;

  UserLoginDetails({this.userName, this.password});
}

@HiveType(typeId:1)
class UserExamDetails{
  @HiveField(0)
  final String? userName;
  @HiveField(1)
  final String? registeringUserName;
  @HiveField(2)
  final String? age;
  @HiveField(4)
  final String? gender;

  UserExamDetails(
      {this.userName, this.registeringUserName, this.age, this.gender});

}