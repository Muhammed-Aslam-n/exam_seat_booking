import 'package:exam_seat_booking/constants/colors.dart';
import 'package:exam_seat_booking/controller/booking_controller.dart';
import 'package:exam_seat_booking/controller/home_controller.dart';
import 'package:exam_seat_booking/database/db_helper.dart';
import 'package:exam_seat_booking/widget/appbar_widget.dart';
import 'package:exam_seat_booking/widget/common_text.dart';
import 'package:exam_seat_booking/widget/exam_detail_widget.dart';
import 'package:exam_seat_booking/widget/login_button.dart';
import 'package:exam_seat_booking/widget/login_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
final hController = HomeController.homeController;

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _zoomDrawerController,
      borderRadius: 24,
      style: DrawerStyle.Style1,
      openCurve: Curves.fastOutSlowIn,
      disableGesture: false,
      mainScreenTapClose: true,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      backgroundColor: primaryColor,
      showShadow: true,
      angle: 0.0,
      clipMainScreen: true,
      mainScreen: BodyWidget(),
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          backgroundColor: primaryColor.withOpacity(0.7),
          body: Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      "assets/images/default_images/defaultExamImage.jpg"),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CommonText(
                  text: hController.username,
                  color: secondaryColor,
                  size: 16,
                ),
                SizedBox(
                  height: 40.h,
                ),
                const Text(
                  "Privacy Policy",
                  style: TextStyle(color: secondaryColor),
                ),
                SizedBox(
                  height: 40.h,
                ),
                const Text(
                  "Terms and Conditions",
                  style: TextStyle(color: secondaryColor),
                ),
                SizedBox(
                  height: 40.h,
                ),
                const Text(
                  "Rate App",
                  style: TextStyle(color: secondaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  BodyWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () {
            bottomSheetWidget(context);
          },
          child: const Icon(Icons.add),

        ),
        body: Scaffold(
          backgroundColor: primaryColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBarWidget(
              controller: _zoomDrawerController,
            ),
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                ExamShortDetailWidget(
                  titleData: hController.examName,
                  yearData: hController.examYear,
                  detailData: hController.examDetail1,
                  imageUrl: hController.imageUrl,
                ),
                SizedBox(
                  height: 30.h,
                ),
                ValueListenableBuilder(
                  valueListenable: HomeController
                      .homeController.userExamDetailsDbInstance!
                      .listenable(),
                  builder: (context, Box<UserExamDetails> userExamDetailsDb, _) {
                    List<int> allKeys =
                        userExamDetailsDb.keys.cast<int>().where((key) => userExamDetailsDb.get(key)!.userId  == hController.userCurrespondingKey).toList();
                    debugPrint(allKeys.isEmpty.toString());
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (allKeys.isEmpty) {
                          return const Text(
                            "No Registration",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                        final userRecordKey = allKeys[index];
                        final userRecord = userExamDetailsDb.get(userRecordKey);
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: secondaryColor.withOpacity(0.8),
                                blurRadius: 1.2,
                                offset: const Offset(0, 0.1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Text(
                              "${userRecord?.age}",
                              style: const TextStyle(color: secondaryColor),
                            ),
                            title: Text(
                              "${userRecord?.registeringUserName}",
                              style: const TextStyle(color: secondaryColor),
                            ),
                            subtitle: Text(
                              "${userRecord?.gender}",
                              style: const TextStyle(color: secondaryColor),
                            ),
                            trailing: Text(
                              "${userRecord?.seatPosition}",
                              style: const TextStyle(color: secondaryColor),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                      itemCount: allKeys.length,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future bottomSheetWidget(context) {
    BookingController.bookingController.didUserClicked = false;
    return Get.bottomSheet(
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Material(
            elevation: 12.0,
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.w),
                      width: MediaQuery.of(context).size.width,
                      height: (MediaQuery.of(context).size.height * 0.23).h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: hController.imageUrl == null
                              ? const AssetImage(
                              "assets/images/default_images/defaultExamImage.jpg")
                          as ImageProvider
                              : NetworkImage(hController.imageUrl.toString()),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: CommonText(
                          text: hController.examName,
                          color: primaryColor,
                          size: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              CommonText(
                                text: hController.examDetail1,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              CommonText(
                                text: hController.examDetail2,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              CommonText(
                                text: "Deadline : ${hController.deadline}",
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              CommonText(
                                text:
                                "Qualification : ${hController.eligibility}",
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              CommonText(
                                text: "Enter Details",
                                color: secondaryColor,
                                size: 18.sp,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              LoginTextField(
                                padding: 0,
                                controller:
                                HomeController.homeController.nameController,
                                errorText: "Name required",
                                hintText: "Name",
                                prefixIcon: CupertinoIcons.person,
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              LoginTextField(
                                padding: 0,
                                controller:
                                HomeController.homeController.ageController,
                                errorText: "Age required",
                                hintText: "Age",
                                minLength: 1,
                                prefixIcon: CupertinoIcons.calendar,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(
                                height: 60.h,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    const Icon(
                                      FontAwesome5.transgender,
                                      color: secondaryColor,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: VerticalDivider(
                                        width: 0.3.w,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: GetBuilder<HomeController>(
                                        id: "dropDownItem",
                                        builder: (homeController) {
                                          return DropdownButton<String>(
                                            isExpanded: true,
                                            underline: const Divider(),
                                            value: homeController
                                                .defaultSelectedItem,
                                            items: homeController.genderOptions
                                                .map(buildDropDownItems)
                                                .toList(),
                                            onChanged: (value) {
                                              homeController.changeDropdownItem(
                                                  value ?? '');
                                              debugPrint(homeController
                                                  .defaultSelectedItem);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: LoginButton(
                                  buttonText: "Select Seat",
                                  height: 35,
                                  width: 250,
                                  textColor: primaryColor,
                                  validateForm: validateForm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  validateForm(context) {
    if (_formKey.currentState!.validate()) {
      hController.enrollUserDetailsForExam();
      hController.prepareSeatBook();
      FocusScope.of(context).unfocus();
    }
  }

  DropdownMenuItem<String> buildDropDownItems(String item) => DropdownMenuItem(
    value: item,
    child: CommonText(
      text: item,
      size: 15,
      color: secondaryColor,
    ),
  );
}
