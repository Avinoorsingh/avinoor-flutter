import 'dart:convert';
import 'package:colab/models/quality_new_checklist.dart';
import 'package:colab/models/section_detail.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';

class GetNewCheckList extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getCheckListData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
      try {
      var getNewQualityCheckListUrl=Uri.parse("${Config.getCheckListForTabsApi}$clientID/${projectID??"1"}/null");
        var res=await http.get(
            getNewQualityCheckListUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          var cData4=jsonDecode(res.body);
          Checklist result5=Checklist.fromJson(cData4['New']);
          signInController.getCheckListData=result5;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting new check list");
                print(e);
              }
            }
  }
}

class GetOpenedCheckList extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getCheckListData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
      try {
      var getOpenedQualityCheckListUrl=Uri.parse("${Config.getCheckListForTabsApi}$clientID/${projectID??"1"}/O");
        var res=await http.get(
            getOpenedQualityCheckListUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          var cData4=jsonDecode(res.body);
          Checklist result5=Checklist.fromJson(cData4['Open']);
          signInController.getOpenedCheckListData=result5;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting opened check list");
                print(e);
              }
            }
  }
}

class GetClosedCheckList extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getCheckListData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
      try {
      var getOpenedQualityCheckListUrl=Uri.parse("${Config.getCheckListForTabsApi}$clientID/${projectID??"1"}/1");
        var res=await http.get(
            getOpenedQualityCheckListUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          var cData4=jsonDecode(res.body);
          Checklist result5=Checklist.fromJson(cData4['Open']);
          signInController.getClosedCheckListData=result5;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting closed check list");
                print(e);
              }
            }
  }
}

class GetSectionDetail{
  Future getDetail({required sectionId,required linkingActivtiyId, required checkCode}) async {
     final signInController = Get.find<SignInController>();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
      try {
      var getSectionDataUrl=Uri.parse("${Config.getSectionDataApi}$sectionId/$linkingActivtiyId/$checkCode");
      print(getSectionDataUrl);
        var res=await http.get(
            getSectionDataUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          var cData4=jsonDecode(res.body);
          SectionDetail result5=SectionDetail.fromJson(cData4['data']);
          signInController.getSectionData=result5;
            } catch (e) {
              if (kDebugMode) {
                print("error in getting section detail");
                print(e);
        }
    }
  }
}