import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class LoginButton extends StatelessWidget {

  final String? buttonText;
  final int? height,width;
  final Color? textColor;
  final Function validateForm;
  const LoginButton({Key? key, required this.buttonText,required this.height,required this.width,required this.textColor,required this.validateForm}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: secondaryColor,
          fixedSize: Size(width!.w, height!.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
      ),
      onPressed: () {
        validateForm(context);
      },
      child: Text(buttonText!,style: TextStyle(color: textColor),),
    );
  }
}
