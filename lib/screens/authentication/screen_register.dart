import 'package:exam_seat_booking/widget/common_text.dart';
import 'package:flutter/material.dart';
import 'package:exam_seat_booking/constants/colors.dart';
import 'package:exam_seat_booking/controller/authentication_controller.dart';
import 'package:exam_seat_booking/widget/login_button.dart';
import 'package:exam_seat_booking/widget/login_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenRegister extends StatelessWidget {
  ScreenRegister({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        LoginController.loginController.clearSignInTextEditingControllers();
        return true;
      },
      child: Scaffold(
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
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 45.w),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: "Sign Up",
                      size: 22,
                      color: secondaryColor,
                      weight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginTextField(
                        controller:
                            LoginController.loginController.signInUserNameController,
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
                            LoginController.loginController.signInPasswordController,
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
      ),
    );
  }

  validateForm(context) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      LoginController.loginController.registerUser();
    }
  }
}
