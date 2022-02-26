import 'package:exam_seat_booking/screens/authentication/screen_login.dart';
import 'package:exam_seat_booking/screens/authentication/screen_register.dart';
import 'package:exam_seat_booking/screens/home/screen_home.dart';
import 'package:exam_seat_booking/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NoteIt - Make Yourself',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        getPages: [
          GetPage(name: '/login', page: () => const ScreenLogin()),
          GetPage(name: '/SignUpPage', page: () => const ScreenRegister()),
          GetPage(name: '/home', page: () => const ScreenHome()),

        ],
      ),
    );
  }
}