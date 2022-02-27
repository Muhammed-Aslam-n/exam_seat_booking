import 'package:exam_seat_booking/controller/booking_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  static HomeController homeController = Get.find();

  TextEditingController nameController = TextEditingController(text: "Muhammed Aslam n");
  TextEditingController ageController = TextEditingController(text: "21");
  TextEditingController genderController = TextEditingController();

  final genderOptions = ['Male','Female','Other'];
  String? defaultSelectedItem = "Male".obs();
  changeDropdownItem(value) {
    defaultSelectedItem = value;
    update(['dropDownItem']);
  }
  int userSelectedGenderValue = 2;

  prepareSeatBook(){
    BookingController.bookingController.gender = defaultSelectedItem;
    BookingController.bookingController.age = int.tryParse(ageController.text)!;
    BookingController.bookingController.userName = nameController.text;
    update();
  }


}