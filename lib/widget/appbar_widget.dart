import 'package:exam_seat_booking/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../constants/colors.dart';

class AppBarWidget extends StatelessWidget {
  final ZoomDrawerController controller;
  const AppBarWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0.0,
      leading: IconButton(
        icon: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Icon(
            Icons.menu,
            color: secondaryColor,
          ),
        ),
        onPressed: () {
          controller.toggle!();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IconButton(onPressed: (){
            HomeController.homeController.logoutUser();
          }, icon: const Icon(FontAwesome.logout,color: secondaryColor,),),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Image.asset(
          "assets/images/appIcon/appIcon2.png",
          height: 50.h,
          width: 150.w,
        ),
      ),
    );
  }
}
