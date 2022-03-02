import 'package:exam_seat_booking/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class BookingController extends GetxController {
  static BookingController bookingController = Get.find();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Box<UserExamDetails>? userExamDetailsDbInstance;

  @override
  void onInit() {
    userExamDetailsDbInstance = Hive.box<UserExamDetails>(userExamDbName);
    fetchUnAvailableSeats();
    unAvailableSeats.clear();
    super.onInit();
  }
  late bool _isLogged;
  checkIfUserLogged()async{
    debugPrint('Checking on Build');
    final SharedPreferences prefs = await _prefs;

    _isLogged = prefs.getBool(userLoggedKey) ?? false;
    if(_isLogged){
      fetchUnAvailableSeats();
    }
    update();
  }
  List<String> unAvailableSeats = <String>[];
  int? loggedUserKey = 0;

  bool didUserClicked = false;
  String? userName;
  int age = 0.obs();
  String? gender = ''.obs();
  String? registeringUsername = ''.obs(), userId = ''.obs();
  String? selectedSeatPosition;
  UserExamDetails? userExamDetailsModel;

  List? examRoom;

  fetchEnrollingUserDetails({required UserExamDetails userExamDetails}) {
    userExamDetailsModel = userExamDetails;
    // debugPrint("Details Getting in Slotting Page are \n${userExamDetailsModel?.registeringUserName}\n${userExamDetailsModel?.age}\n${userExamDetailsModel?.gender}\n${userExamDetailsModel?.userId}\n${userExamDetailsModel?.seatPosition}}");
    update();
  }

  finalizeUserSeat() {
    final model = UserExamDetails(
      seatPosition: selectedSeatPosition,
      age: userExamDetailsModel?.age,
      registeringUserName: userExamDetailsModel?.registeringUserName,
      gender: userExamDetailsModel?.gender,
      userId: userExamDetailsModel?.userId,
    );
    userExamDetailsDbInstance?.add(model);
    didUserClicked = false;
    Get.offNamed('/home');
    update();
  }

  fetchUnAvailableSeats() {
    unAvailableSeats.clear();
    for (var element in userExamDetailsDbInstance!.values) {
      if (element.seatPosition != null) {
        unAvailableSeats.add(element.seatPosition!);
      }
    }
    debugPrint("UnAvailable Seats are $unAvailableSeats");
  }

  final seatNameList = List.generate(numberOfSeatColumns,
      (index) => index == 0 || index == 4 || index == 5 ? -1 : index);

  String? setSeatName(index) {
    return String.fromCharCode(index + 65);
  }

  showExamRoom() {
    debugPrint(
        "Getting values are ${userExamDetailsModel?.gender} and ${userExamDetailsModel?.age}");
    int? age = int.tryParse(userExamDetailsModel?.age as String);

    examRoom = List.generate(
      numberOfSeatRows,
      (index1) => List.generate(
        numberOfSeatColumns,
        (index2) => index2 == 0
            ? String.fromCharCode(index1 + 65)
            : userExamDetailsModel?.gender == 'Female'
                ? age! <= 20
                    ? index2 == 1 ||
                            index2 == 3 ||
                            index2 == 4 ||
                            index2 == 5 ||
                            index2 == 6 ||
                            index2 == 8
                        ? -1
                        : 1
                    : age > 20 && age < 29
                        ? 1
                        : index2 == 0 ||
                                index2 == 6 ||
                                index2 == 3 ||
                                index1 >= 7
                            ? -1
                            : 1
                : age! <= 20
                    ? index2 == 1 || index2 == 8
                        ? -1
                        : 1
                    : age > 20 && age < 29
                        ? 1
                        : index1 > 7
                            ? -1
                            : 1,
      ),
    );

    if (userExamDetailsDbInstance!.isNotEmpty) {
      dynamic unAVArray = unAvailableSeats.join();
      unAVArray = unAVArray.split('');
      int rowNum;
      for (var i = 0; i < unAVArray.length; i = i + 2) {
        rowNum = getRowIndex(unAVArray[i]);
        examRoom![rowNum][int.tryParse(unAVArray[i + 1]) as int] = -1;
      }
    }
    update();
  }

  getRowIndex(String value) {
    var k = value.toUpperCase().codeUnitAt(0);
    int index = k - 65;
    return index;
  }

  selectNewSeat(int rowIndex, int columnIndex) {

    debugPrint("Getting RowIndex is $rowIndex and ColumnIndex is $columnIndex");

    examRoom![rowIndex][columnIndex] == 1
        ? examRoom![rowIndex][columnIndex] = 2
        : examRoom![rowIndex][columnIndex] = 1;
    selectedSeatPosition = examRoom![rowIndex].first.toString() + seatNameList[columnIndex].toString();
    debugPrint("Selected Position is $selectedSeatPosition");
    examRoom![rowIndex][columnIndex] != 1
        ? debugPrint("Selected")
        : debugPrint("DeSelected");
    didUserClicked == true ? didUserClicked = false : didUserClicked = true;
    update();
  }
}
