import 'package:exam_seat_booking/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamShortDetailWidget extends StatelessWidget {
  final String? titleData, yearData, detailData;
  final Color? headColor, dataColor;
  final dynamic imageUrl;

  const ExamShortDetailWidget(
      {Key? key,
      required this.titleData,
      required this.yearData,
      required this.detailData,
      this.headColor,
      this.dataColor,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: primaryColor,
      title: Text(
        titleData ?? 'Exam name not found',
        style: TextStyle(
            color: dataColor ?? Colors.white, overflow: TextOverflow.ellipsis),
      ),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Text(
            yearData ?? 'year not found',
            style: TextStyle(
                color: dataColor ?? Colors.white,
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            detailData ?? 'details not found',
            style: TextStyle(
                color: dataColor ?? Colors.white,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: imageUrl == null
            ? Image.asset("assets/images/default_images/defaultExamImage.jpg")
            : Image.network(imageUrl),
      ),
    );
  }
}
