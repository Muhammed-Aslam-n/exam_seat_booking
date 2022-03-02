import 'package:exam_seat_booking/constants/constants.dart';
import 'package:exam_seat_booking/controller/home_controller.dart';
import 'package:exam_seat_booking/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static LoginController loginController = Get.find();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Controllers for TextFormField
  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController signInUserNameController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  Box<UserLoginDetails>? userLoginDbInstance;

  @override
  void onInit() {
    userLoginDbInstance = Hive.box<UserLoginDetails>(userLoginDbName);
    super.onInit();
  }

  registerUser() async {
    bool isAlreadyExist = false;
    for (var element in userLoginDbInstance!.values) {
      if (element.userName == signInUserNameController.text) {
        isAlreadyExist = true;
      }
    }
    if (isAlreadyExist) {
      snackBar("User Already Exist");
    } else {
      final model = UserLoginDetails(
          userName: signInUserNameController.text,
          password: signInPasswordController.text);
      await initializeApp();
      userLoginDbInstance
          ?.add(model);
      await initializeApp();
      await HomeController.homeController.checkIfUserLogged().then((value) => Get.offNamed('/home'));
      debugPrint("New User Registered Successfully");
    }
    clearSignInTextEditingControllers();
  }

  loginUser() async {
    bool isRegistered = false;
    for (var element in userLoginDbInstance!.values) {
      if (element.userName == loginUserNameController.text &&
          element.password == loginPasswordController.text) {
        isRegistered = true;
      }
    }
    if (isRegistered) {
      await initializeApp();
      await HomeController.homeController.checkIfUserLogged();
      clearLoginTextEditingControllers();
      Get.offNamed('/home');
    } else {
      snackBar("Incorrect User credentials");
    }
  }

  initializeApp() async {
    final SharedPreferences prefs = await _prefs;
    bool _isLaunched = prefs.getBool(appLaunchKey) ?? false;
    debugPrint("IsLaunched? $_isLaunched");

    if (_isLaunched == false) {
      bool launchValue = await prefs.setBool(appLaunchKey, true);
      debugPrint("Made Launch value $launchValue");
    }
    bool value = await prefs.setBool(userLoggedKey, true);
    await prefs.setString(currentUserNameKey, loginUserNameController.text);
    String? usernameValue = prefs.getString(currentUserNameKey);
    debugPrint("Made Login value $value, Username = $usernameValue");
    update();
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

  clearLoginTextEditingControllers() {
    loginUserNameController.clear();
    loginPasswordController.clear();
  }

  clearSignInTextEditingControllers() {
    signInPasswordController.clear();
    signInUserNameController.clear();
  }

  @override
  void dispose() {
    loginUserNameController.dispose();
    loginPasswordController.dispose();
    signInPasswordController.dispose();
    signInUserNameController.dispose();
    super.dispose();
  }
}
