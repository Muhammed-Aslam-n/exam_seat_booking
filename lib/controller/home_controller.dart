import 'package:exam_seat_booking/api_service/api_service.dart';
import 'package:exam_seat_booking/constants/constants.dart';
import 'package:exam_seat_booking/controller/booking_controller.dart';
import 'package:exam_seat_booking/database/db_helper.dart';
import 'package:exam_seat_booking/model/exam_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeController extends GetxController{
  static HomeController homeController = Get.find();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Box<UserLoginDetails>? userLoginDbInstance;
  Box<UserExamDetails>? userExamDetailsDbInstance;
  // Box<User>

  @override
  void onInit() async{
    userLoginDbInstance = Hive.box<UserLoginDetails>(userLoginDbName);
    userExamDetailsDbInstance = Hive.box<UserExamDetails>(userExamDbName);
    await checkIfUserLogged();
    // userExamDetailsDbInstance?.clear();
    fetchHomeExamDetails();
    super.onInit();
  }
  late bool _isLogged;
  String? _currentLoggedUserName;

  checkIfUserLogged()async{
    debugPrint('Checking on Build');
    final SharedPreferences prefs = await _prefs;
    _currentLoggedUserName = prefs.getString(currentUserNameKey);

    debugPrint('currentUserName on Build $_currentLoggedUserName');
    _isLogged = prefs.getBool(userLoggedKey) ?? false;
    if(_isLogged){
      debugPrint("Fetching0");
      await fetchUserDetails();
    }
    update();
  }

  String? examName;
  String? examDetail1,examDetail2;
  String? examYear;
  String? deadline,eligibility;
  dynamic imageUrl;

  String? username;
  int userCurrespondingKey = 0;

  fetchUserDetails() async{
    debugPrint("CurrentUSERNAME $_currentLoggedUserName");
    var keys = userLoginDbInstance?.keys.cast<int>().where((key) => userLoginDbInstance?.get(key)?.userName == _currentLoggedUserName).toList();
      final record = userLoginDbInstance?.get(keys![0]);
      username = record?.userName;
      userCurrespondingKey = keys!.first;
    update();
  }

  enrollUserDetailsForExam(){
     final model = UserExamDetails(userId: userCurrespondingKey,age: ageController.text,gender: defaultSelectedItem,registeringUserName: nameController.text);
     BookingController.bookingController.fetchEnrollingUserDetails(userExamDetails: model);
     BookingController.bookingController.fetchUnAvailableSeats();
     Get.toNamed('/screenSlots');
  }


  TextEditingController nameController = TextEditingController(text: "Muhammed Aslam n");
  TextEditingController ageController = TextEditingController(text: "20");

  final genderOptions = ['Male','Female','Other'];
  String? defaultSelectedItem = "Female".obs();
  changeDropdownItem(value) {
    defaultSelectedItem = value;
    update(['dropDownItem']);
  }
  int userSelectedGenderValue = 2;


  prepareSeatBook(){
    BookingController.bookingController.gender = defaultSelectedItem;
    BookingController.bookingController.age = int.tryParse(ageController.text)!;
    BookingController.bookingController.userName = nameController.text;
    update();
  }


  fetchHomeExamDetails() async{
    ExamHomeDetails? examHomeDetails = await ApiService().fetchExamDetails();
    examName = examHomeDetails?.title;
    examYear = examHomeDetails?.year;
    examDetail1 = examHomeDetails?.detail1;
    examDetail2 = examHomeDetails?.detail2;
    deadline = DateFormat.yMd().format(examHomeDetails?.examDate == null?DateTime.now():examHomeDetails!.examDate as DateTime);
    eligibility = examHomeDetails?.eligibility;
    imageUrl = examHomeDetails?.image;
    update();
  }

  logoutUser() async{
    final SharedPreferences prefs = await _prefs;
    final value = prefs.clear();
    debugPrint("Made Login value $value");
      Get.offNamed('/login');
  }


}