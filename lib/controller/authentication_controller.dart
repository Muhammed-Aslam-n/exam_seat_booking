import 'package:exam_seat_booking/constants/constants.dart';
import 'package:exam_seat_booking/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginController extends GetxController{
  static LoginController loginController = Get.find();

  //Controllers for TextFormField
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Box<UserLoginDetails>? userLoginDbInstance;
  @override
  void onInit() {
    userLoginDbInstance = Hive.box<UserLoginDetails>(userLoginDbName);
    super.onInit();
  }
  registerUser(){
    bool isAlreadyExist = false;
    debugPrint("New User Registered Successfully");
    for (var element in userLoginDbInstance!.values) {
      if(element.userName == userNameController.text){
        isAlreadyExist = true;
      }
    }
    if(isAlreadyExist){
      snackBar("User Already Exist");
    }else{
      final model = UserLoginDetails(userName: userNameController.text,password: passwordController.text);
      userLoginDbInstance?.add(model);
    }
    clearTextEditingControllers();
  }

  loginUser(){
    bool isRegistered = false;
    for (var element in userLoginDbInstance!.values) {
      if(element.userName == userNameController.text && element.password == passwordController.text){
        isRegistered = true;
      }
    }
    if(isRegistered){
      Get.offNamed('/home');
    }else{
      snackBar("Incorrect User credentials");
    }
  }



  snackBar(error, {title, color, duration}) {
    Get.snackbar(
      "",
      "",
      backgroundColor: color ?? Colors.redAccent,
      duration: Duration(seconds: duration ?? 1),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        title ?? '',
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        error.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  clearTextEditingControllers(){
    userNameController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

}