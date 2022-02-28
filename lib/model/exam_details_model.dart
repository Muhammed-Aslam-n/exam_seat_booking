// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
//
// ExamHomeDetails examHomeDetails(String str) => ExamHomeDetails.fromJson(json.decode(str));

String welcomeToJson(ExamHomeDetails data) => json.encode(data.toJson());

class ExamHomeDetails {
  ExamHomeDetails({
    this.id,
    this.ticker,
    this.title,
    this.year,
    this.examDate,
    this.image,
    this.detail1,
    this.detail2,
    this.detail3,
    this.eligibility,
  });

  int? id;
  String? ticker;
  String? title;
  String? year;
  DateTime? examDate;
  dynamic image;
  String? detail1;
  String? detail2;
  String? detail3;
  String? eligibility;

  factory ExamHomeDetails.fromJson(Map<String, dynamic> json) => ExamHomeDetails(
    id: json["id"],
    ticker: json["ticker"],
    title: json["title"],
    year: json["year"],
    examDate: DateTime.parse(json["exam_date"]),
    image: json["image"],
    detail1: json["detail1"],
    detail2: json["detail2"],
    detail3: json["detail3"],
    eligibility: json["Eligibility"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticker": ticker,
    "title": title,
    "year": year,
    "exam_date": examDate?.toIso8601String(),
    "image": image,
    "detail1": detail1,
    "detail2": detail2,
    "detail3": detail3,
    "Eligibility": eligibility,
  };
}
