import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController loginController = Get.find();

  //Controllers for TextFormField
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();




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