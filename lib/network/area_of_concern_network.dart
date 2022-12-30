import 'dart:convert';
import 'package:colab/models/area_of_concern_model.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';

class GetAreaOfConcern extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getAreaOfConcernData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
      try {
      var getAreaOfConcernUrl=Uri.parse("${Config.getAreaOfConcernApi}$clientID/${projectID??"1"}/null");
        var res=await http.get(
            getAreaOfConcernUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          var cData=jsonDecode(res.body);
          AreaOfConcern result=AreaOfConcern.fromJson(cData);
          signInController.getAreaOfConcData=result;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting opened check list");
                print(e);
              }
            }
  }
}