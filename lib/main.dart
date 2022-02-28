import 'package:exam_seat_booking/constants/constants.dart';
import 'package:exam_seat_booking/controller/booking_controller.dart';
import 'package:exam_seat_booking/controller/home_controller.dart';
import 'package:exam_seat_booking/controller/authentication_controller.dart';
import 'package:exam_seat_booking/database/db_helper.dart';
import 'package:exam_seat_booking/screens/authentication/screen_login.dart';
import 'package:exam_seat_booking/screens/authentication/screen_register.dart';
import 'package:exam_seat_booking/screens/booking/screen_sloting.dart';
import 'package:exam_seat_booking/screens/home/screen_home.dart';
import 'package:exam_seat_booking/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  Get.put(BookingController());
  Get.put(HomeController());
  Get.put(LoginController());
  runApp(const MyApp());
}

initializeHive() async{
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserLoginDetailsAdapter());
  Hive.registerAdapter(UserExamDetailsAdapter());
  await Hive.openBox<UserLoginDetails>(userLoginDbName);
  await Hive.openBox<UserExamDetails>(userExamDbName);
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
          GetPage(name: '/login', page: () => ScreenLogin()),
          GetPage(name: '/SignUpPage', page: () => ScreenRegister()),
          GetPage(name: '/home', page: () => const ScreenHome()),
          GetPage(name: '/screenSlots', page: () => const ScreenSlot()),
        ],
      ),
    );
  }
}
