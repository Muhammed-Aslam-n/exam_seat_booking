import 'package:dio/dio.dart';
import 'package:exam_seat_booking/constants/constants.dart';
import 'package:exam_seat_booking/model/exam_details_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
class ApiService {

  Dio? _dio;
  ApiService(){
    _dio = Dio();
  }

  Future<ExamHomeDetails?>fetchExamDetails() async{
    debugPrint("Function to fetch exam details called");
    try{
       Response examHomeResponse = await _dio!.get(baseUrl);
       final body = json.decode(examHomeResponse.data);
       ExamHomeDetails examHomeDetails = ExamHomeDetails.fromJson(body);
       return examHomeDetails;
    }on DioError catch(dioError){
      debugPrint("FetchExamDetails: error Message ${dioError.message}");
      debugPrint("FetchExamDetails: error response ${dioError.response}");
      debugPrint("FetchExamDetails: error Status Code ${dioError.response?.statusCode}");
    }
    return null;
  }

}