import 'package:exam_seat_booking/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';

class BookingController extends GetxController {
  static BookingController bookingController = Get.find();

  Box<UserExamDetails>? userExamDetailsDbInstance;

  @override
  void onInit() {
    userExamDetailsDbInstance = Hive.box<UserExamDetails>(userExamDbName);
    fetchUnAvailableSeats();
    unAvailableSeats.clear();
    super.onInit();
  }

  final seatColumnNumber = [
    '',
    '1',
    '2',
    '3',
    '',
    '',
    '4',
    '5',
    '6',
  ];

  String? setSeatName(index) {
    return String.fromCharCode(index + 65);
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

  List<Map<String, dynamic>>? examRoom;

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

  showExamRoom() {
    examRoom = List.generate(
        13,
        (index1) => {
              'seatRowName': setSeatName(index1),
              'seatColNum': [...seatColumnNumber],
              'value': List.generate(
                9,
                (index) => gender == 'Female'
                    ? age <= 20
                        ? index == 1 ||
                                index == 3 ||
                                index == 4 ||
                                index == 5 ||
                                index == 6 ||
                                index == 8
                            ? 0
                            : 1
                        : index == 0 || index == 6 || index == 3 || index1 >= 7
                            ? 0
                            : 1
                    : int.tryParse(userExamDetailsModel?.age as String)! <= 20
                        ? index == 1 || index == 8
                            ? 0
                            : 1
                        : index1 > 7
                            ? 0
                            : 1,
              ),
            },
        growable: false);
    update();
  }

  selectNewSeat(int rowIndex, int columnIndex) {
    examRoom![rowIndex]['value'][columnIndex] == 1
        ? examRoom![rowIndex]['value'][columnIndex] = 2
        : examRoom![rowIndex]['value'][columnIndex] = 1;
    selectedSeatPosition = examRoom![rowIndex]['seatRowName'] +
        examRoom![rowIndex]['seatColNum'][columnIndex];
    debugPrint("Selected Position is $selectedSeatPosition");
    examRoom![rowIndex]['value'][columnIndex] != 1
        ? debugPrint("Selected")
        : debugPrint("DeSelected");
    didUserClicked == true ? didUserClicked = false : didUserClicked = true;
    update();
  }
}
