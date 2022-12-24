import 'dart:convert';
import 'package:colab/models/quality_new_checklist.dart';
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