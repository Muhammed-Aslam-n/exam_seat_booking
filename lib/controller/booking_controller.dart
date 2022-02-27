import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  static BookingController bookingController = Get.find();
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
  String? seatAlphaName;

  String? setSeatName(index) {
    return String.fromCharCode(index + 65);
  }

  bool didUserClicked = false;
  String? userName;
  int age = 20;
  String? gender = ''.obs();
  List<Map<String, dynamic>>? examRoom;

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
                    : age <= 20
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
    debugPrint(
        "Selected Position is ${examRoom![rowIndex]['seatRowName']}${examRoom![rowIndex]['seatColNum'][columnIndex]}");
    examRoom![rowIndex]['value'][columnIndex] != 1
        ? debugPrint("Selected")
        : debugPrint("DeSelected");
    didUserClicked == true ? didUserClicked = false : didUserClicked = true;
    update();
  }
}
