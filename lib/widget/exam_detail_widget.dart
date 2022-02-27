import 'package:exam_seat_booking/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamShortDetailWidget extends StatelessWidget {
  final String? titleData,yearData,detailData;
  final Color? headColor,dataColor;
  final String? imageUrl;
  const ExamShortDetailWidget({Key? key,required this.titleData,required this.yearData, required this.detailData, this.headColor, this.dataColor, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: primaryColor,
      title: Row(
        children: [
          Text("Title :",style: TextStyle(color: headColor??secondaryColor),),
          SizedBox(width: 2.w,),
          Flexible(child: Text(titleData??'Exam name not found',style: TextStyle(color: dataColor??primaryTextColor,overflow: TextOverflow.ellipsis),))
        ],
      ),
      isThreeLine: true,
      subtitle: Column(
        children: [
          SizedBox(height: 5.h,),
          Row(
            children: [
              Text("Year  :",style: TextStyle(color: headColor??secondaryColor),),
              SizedBox(width: 2.w,),
              Text(yearData??'year not found',style: TextStyle(color: dataColor??primaryTextColor),)
            ],
          ),
          SizedBox(height: 5.h,),
          Row(
            children: [
              Text("Detail 1 :",style: TextStyle(color: headColor??secondaryColor),),
              SizedBox(width: 2.w,),
              Text(detailData??'details not found',style: TextStyle(color: dataColor??primaryTextColor),)
            ],
          ),
        ],
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Image.asset(imageUrl??"assets/images/default_images/defaultExamImage.jpg"),
      ),
    );
  }
}
