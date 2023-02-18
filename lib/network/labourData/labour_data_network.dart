import 'dart:convert';
import 'package:colab/models/labour_data_contractor_list.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/signInController.dart';
import '../../models/labour_name_contractor_list.dart';
import '../../models/labour_today_data_list.dart';

class GetLabourDataContractor extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getContractorListData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     // ignore: unused_local_variable
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getContractorListDataUrl=Uri.parse("${Config.getLabourDataContractorListApi}$clientID/$projectID");
        var res=await http.get(
            getContractorListDataUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> data=jsonDecode(res.body);
          LabourDataContractorList result=LabourDataContractorList.fromJson(data);
          signInController.getLabourDataContractorListData=result;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting labour data contractor list");
                print(e);
              }
            }
  }
}

class GetSelectedContractorData extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getSelectedContractorData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     // ignore: unused_local_variable
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getContractorDataUrl=Uri.parse("${Config.getLabourNameOfContractorApi}$clientID/$projectID");
        var res=await http.get(
            getContractorDataUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> data=jsonDecode(res.body);
          LabourNameContractorList result=LabourNameContractorList.fromJson(data);
          signInController.getLabourDataOfSelectedContractor=result;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting labour data contractor list");
                print(e);
              }
            }
  }
}

class GetLabourDataToday extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getContractorListData({token, required BuildContext context,required date}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     // ignore: unused_local_variable
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getLabourByDateUrl=Uri.parse("${Config.getLabourDataOfTodayApi}$date/$clientID/$projectID");
      var res=await http.get(
            getLabourByDateUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> data=jsonDecode(res.body);
          if(data['success']==true){
          LabourTodayDataList result=LabourTodayDataList.fromJson(data);
          signInController.getLabourByDate=result;
          }
          else if(data['success']==false){
            signInController.getLabourByDate?.data=null;
          }
          update();
        } catch (e) {
              if (kDebugMode) {
                print("error in getting labour data by date");
                print(e);
              }
            }
  }
}