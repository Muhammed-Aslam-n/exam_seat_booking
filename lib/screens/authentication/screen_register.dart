import 'package:flutter/material.dart';
import 'package:exam_seat_booking/constants/colors.dart';
import 'package:exam_seat_booking/constants/constants.dart';
import 'package:exam_seat_booking/controller/authentication_controller.dart';
import 'package:exam_seat_booking/widget/common_text.dart';
import 'package:exam_seat_booking/widget/login_button.dart';
import 'package:exam_seat_booking/widget/login_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenRegister extends StatelessWidget {
  ScreenRegister({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Image.asset(
                "assets/images/appIcon/appIcon2.png",
                height: 100.h,
                width: 200.w,
              ),
              SizedBox(
                height: 50.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginTextField(
                      controller:
                          LoginController.loginController.userNameController,
                      errorText: "Username required",
                      hintText: "Username",
                      prefixIcon: CupertinoIcons.person,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    LoginTextField(
                      controller:
                          LoginController.loginController.passwordController,
                      errorText: "Password required",
                      hintText: "Password",
                      prefixIcon: CupertinoIcons.lock,
                      minLength: 5,
                      keyboardType: TextInputType.visiblePassword,
                      obscureTex: true,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    LoginButton(
                      buttonText: "Join",
                      height: 45,
                      width: 200,
                      textColor: primaryColor,
                      validateForm: validateForm,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateForm(context) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final SharedPreferences prefs = await _prefs;
      bool _isLaunched = prefs.getBool(appLaunchKey) ?? true;
      debugPrint("IsInitialLaunch? $_isLaunched");
      if (_isLaunched) {
        bool value = prefs.setBool(userLoggedKey, true) as bool;
        debugPrint("Made Login value $value");
      }
      Future.delayed(const Duration(milliseconds: 1000))
          .then((value) => Get.offNamed('/home'));
    }
  }
}
