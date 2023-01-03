import 'dart:convert';
import 'package:colab/models/completedProgress.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';

class GetCompletedSiteProgress extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getCompletedListData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
      try {
      var getCompletedProgressListUrl=Uri.parse("${Config.getLocationProgressApi}$clientID/${projectID??"1"}/COM");
        var res=await http.get(
            getCompletedProgressListUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          var cData4=jsonDecode(res.body);
          CompletedProgress result5=CompletedProgress.fromJson(cData4);
          signInController.getCompletedProgressData=result5;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting new check list");
                print(e);
              }
            }
  }
}