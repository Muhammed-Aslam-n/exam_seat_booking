import 'package:exam_seat_booking/constants/colors.dart';
import 'package:exam_seat_booking/controller/booking_controller.dart';
import 'package:exam_seat_booking/widget/common_text.dart';
import 'package:exam_seat_booking/widget/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenSlot extends StatefulWidget {
  const ScreenSlot({Key? key}) : super(key: key);

  @override
  State<ScreenSlot> createState() => _ScreenSlotState();
}

class _ScreenSlotState extends State<ScreenSlot> {
  final hController = BookingController.bookingController;
  @override
  Widget build(BuildContext context) {
    hController.showExamRoom();
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              const CommonText(
                text: "Select Seat",
                color: Colors.white,
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: GetBuilder<BookingController>(
                  builder: (hController) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < 9; i++)
                              i == 0 || i == 4 || i == 5
                                  ? const SizedBox(
                                      height: 40.0,
                                      width: 40.0,
                                    )
                                  : Expanded(
                                      child: Text(
                                        "\t" +
                                            hController
                                                .examRoom![i]['seatColNum'][i]
                                                .toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                          ],
                        ),
                        for (int i = 0; i <= 12; i++)
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                for (int x = 1; x <= 9; x++)
                                  Expanded(
                                    child: (x == 5) || (x == 6)
                                        ? const SizedBox()
                                        : x == 1
                                            ? Text(hController.examRoom![i]
                                                ['seatRowName'])
                                            : Container(
                                                margin: const EdgeInsets.all(5),
                                                child: hController.examRoom![i]
                                                            ['value'][x - 1] ==
                                                        0
                                                    ? unAvailableChair(i, x - 1)
                                                    : hController.examRoom![i]
                                                                ['value'][x - 1] !=
                                                            2
                                                        ? availableChair(
                                                            i,
                                                            x - 1,
                                                          )
                                                        : reservedChair(
                                                            i,
                                                            x - 1,
                                                          ),
                                                // child: femaleLessThan20[i][''],
                                              ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              LoginButton(
                  buttonText: "Submit",
                  height: 35,
                  width: 200,
                  textColor: primaryColor,
                  validateForm: validateForm),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }


  validateForm(context) {
    if (hController.didUserClicked) {
      hController.finalizeUserSeat();
    }
  }

  Widget unAvailableChair(int a, int b) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
          color: Colors.redAccent, borderRadius: BorderRadius.circular(3.0)),
    );
  }

  Widget availableChair(int rowIndex, int columnIndex) {
    return GestureDetector(
      onTap: () {
        if(!hController.didUserClicked){
          hController.selectNewSeat(rowIndex,columnIndex);
        }
      },
      child: Container(
        height: 30.0,
        width: 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(
            color: const Color.fromRGBO(0, 0, 0, 1),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget reservedChair(rowIndex, columnIndex) {
    return GestureDetector(
      onTap: () {
        hController.selectNewSeat(rowIndex, columnIndex);
      },
      child: Container(
        height: 30.0,
        width: 10.0,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(3.0)),
      ),
    );
  }
}
