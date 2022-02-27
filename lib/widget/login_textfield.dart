import 'package:exam_seat_booking/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorText, hintText;
  final TextInputType? keyboardType;
  final bool? obscureTex;
  final int minLength;
  final IconData? prefixIcon;
  final double? padding;

  const LoginTextField(
      {Key? key, required this.controller, required this.errorText, required this.hintText, required this.prefixIcon, this.minLength = 3, this.keyboardType, this.obscureTex, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding??40.w),
      child: TextFormField(
        obscureText: obscureTex ?? false,
        keyboardType: keyboardType,
        style: const TextStyle(color: secondaryColor),
        controller: controller,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return errorText;
          } else if (inputValue.length < minLength) {
            return "Minimum $minLength character required";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          errorStyle:
          TextStyle(color: primaryTextColor),
          prefixIcon: SizedBox(
            width: 50,
            child: Row(
              children: [
                Icon(
                  prefixIcon ?? CupertinoIcons.person,
                  color: secondaryColor,
                ),
                SizedBox(width: 10.w,),
                SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    width: 0.3.w,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          hintText: hintText,
          border: InputBorder.none,
          hintStyle:
          TextStyle(color: secondaryColor, fontSize: 15.sp),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: secondaryColor, width: 0.3.w),
          ),
        ),
      ),
    );
  }
}
