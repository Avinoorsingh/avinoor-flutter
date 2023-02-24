import 'dart:convert';
import 'package:colab/models/category_list.dart';
import 'package:colab/models/clientEmployee.dart';
import 'package:colab/models/client_response.dart';
import 'package:colab/models/labour_attendance.dart';
import 'package:colab/models/location_list.dart';
import 'package:colab/models/login_response_model.dart';
import 'package:colab/models/login_user.dart';
import 'package:colab/models/progress_contractor.dart';
import 'package:colab/models/progress_count.dart';
import 'package:colab/models/progress_location_data.dart';
import 'package:colab/models/progress_trade_data.dart';
import 'package:colab/models/snag_data.dart';
import 'package:colab/models/snags_count.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';

class GetClientProject extends GetxController {
  final signInController = Get.find<SignInController>();
  List<ClientProfileData> getClientProjects= [];
  bool isLoading = true;
  var clientProjects = <ClientProfileData>[];
  ClientProfileData? getSingleProjectData;
  getUpcomingProjects(
      {
      required BuildContext context,
     }) async {
    try {
      isLoading = true;
      var getUserDataUrl=Uri.parse(Config.getUserDataApi);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var tokenValue=sharedPreferences.getString('token');
          var clientId=sharedPreferences.getString('client_id');
          var id=sharedPreferences.getString('id'); 
      var res=await http.get(
            getUserDataUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $tokenValue",
              'client_id':clientId.toString(),
              'id':id.toString(),
            }
            );
           var resSuccess=jsonDecode(res.body);
           if(resSuccess['data'].length>1){
            clientProjects.clear();
             for(int i=0;resSuccess['data'].length;i++){
            clientProjects.add(ClientProfileData.fromJson(resSuccess['data'][i]));
           }
      if(getClientProjects.isEmpty){
      getClientProjects = clientProjects.toSet().toList();
      }
      isLoading = false;
      update();
           }
    } catch (e) {
      isLoading = false;
      // update();
      if (kDebugMode) {
        print('getClientData nhi chali !!');
        print(e);
      }
    }
  }


   getSelectedProjects(
      {
      selectedDate,
      required BuildContext context,
     }) async {
    try {
      isLoading = true;
      print("I am here");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var tokenValue=sharedPreferences.getString('token');
          var clientId=sharedPreferences.getString('client_id');
          var id=sharedPreferences.getString('id'); 
          var date=sharedPreferences.getString('date');
          var index=sharedPreferences.getString('index');
          if(selectedDate!=null || date!=null){
          var getUserDataUrl=Uri.parse(Config.getSelectedProjectApi+(selectedDate??date));
          var res=await http.get(
            getUserDataUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $tokenValue",
              'client_id':clientId!,
              'id':id!,
            }
            );
           Map<String, dynamic> resSuccess;
           resSuccess={};
           resSuccess=jsonDecode(res.body);
           if(resSuccess['data']!=null){
           if(resSuccess['data'].length>1){
             clientProjects.clear();
             for(int i=0;i<resSuccess['data'].length;i++){
             clientProjects.add(ClientProfileData.fromJson(resSuccess['data'][i]));
             }
            if(index!=null){
            signInController.getProjectData= clientProjects[int.parse(index)];
            update();
          }
      if(getClientProjects.isEmpty){
      getClientProjects = clientProjects.toSet().toList();
      }
      isLoading = false;
      update();
           }
            else if(resSuccess['data'].length<=1){
              try {
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              String id=resSuccess['data'][0]['project_id'].toString();
              if(id.isNotEmpty){
              sharedPreferences.setString("projectIdd",id);
              }
              if(resSuccess['data'][0]!=null){
               var result= ClientProfileData.fromJson(resSuccess['data'][0]);
                signInController.getProjectData=result;
              }
                update();
              } catch (e) {
                if (kDebugMode) {
                  print("error");
                  print(e);
                }
              }
            }
           }
          }
    } catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      if (kDebugMode) {
        print('getProject data nhi chali !!');
        print(e);
      }
    }
  }
}



class GetUserProfileNetwork extends GetxController{
  final signInController = Get.find<SignInController>();
  final getClientProjectsController = Get.find<GetClientProject>();
  static var client=http.Client();
  Future getUserProfile({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var email=sharedPreferences.getString('userName');
     var password=sharedPreferences.getString('password');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      isClient;
     LoginUserModel model= LoginUserModel(userId: email, password: password);
   Map<String, String> requestHeaders={
      'Content-Type':'application/json',
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    try {
    var url=Uri.parse(Config.loginApi);
    // update();
    var response=await client.post(
    url, 
    headers: requestHeaders,
    body: jsonEncode(model.toJson())
    );
    Map<String,dynamic>  cData= jsonDecode(response.body);
    LoginResponseModel result = LoginResponseModel.fromJson(cData['data']);
    signInController.getClientProfile = result;
    ClientProfileData result1=ClientProfileData.fromJson(cData['data']);
    signInController.getProjectData=result1;
    await getClientProjectsController.getSelectedProjects(context: context,selectedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var projectID=sharedPreferences.getString('projectIdd');
    try {
    if(signInController.getProjectData?.clientid!=null || projectID!=null){
       var getCategoryListUrl=Uri.parse("${Config.getCategoryListApi}${signInController.getProjectData!.clientid}/${projectID??"1"}");
       var res=await http.get(
            getCategoryListUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            }
          );
          Map<String,dynamic> cData2=jsonDecode(res.body);
          if(cData2['data']!=null){
          CategoryList result2=CategoryList.fromJson(cData2['data']);
          signInController.getCategoryList=result2;
          }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in getting category list");
        print(e); 
      }
    }
    try {
     var getLocationListUrl=Uri.parse(Config.locationListApi);
        var res=await http.post(
            getLocationListUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
              "client_id":signInController.getProjectData?.clientid.toString(),
              "project_id":projectID,
            }
            );
          Map<String,dynamic> cData3=jsonDecode(res.body);
          LocationList result3=LocationList.fromJson(cData3['data']);
          signInController.getLocationList=result3;
          // print("hello---hello");
          update();
        } catch (e) {
              if (kDebugMode) {
        print("error in getting location list");
        print(e);
      }
    }
    try {
     var getProgressLocationListUrl=Uri.parse(Config.getProgressLocationListApi);
        var res=await http.post(
            getProgressLocationListUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
              "client_id":signInController.getProjectData?.clientid.toString(),
              "project_id":projectID,
            }
            );
          Map<String,dynamic> cData3=jsonDecode(res.body);
          ProgressLocationData result3=ProgressLocationData.fromJson(cData3);
          signInController.getProgressLocationList=result3;    
            } catch (e) {
              if (kDebugMode) {
                print("error in getting progress location list");
                print(e);
              }
            }
    try {
     var getProgressContractorListUrl=Uri.parse(Config.getProgressContractorApi);
        var res=await http.post(
            getProgressContractorListUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
              "client_id":signInController.getProjectData?.clientid.toString(),
              "project_id":projectID,
            }
            );
          Map<String,dynamic> cData3=jsonDecode(res.body);
          ProgressContractor result3=ProgressContractor.fromJson(cData3);
          signInController.getProgressContractorList=result3;    
          } catch (e) {
              if (kDebugMode) {
                print("error in getting progress contractor list");
                print(e);
              }
          }
           try {
     var getProgressTradeUrl=Uri.parse(Config.getProgressTradeApi);
        var res=await http.get(
            getProgressTradeUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            );
          Map<String,dynamic> cData3=jsonDecode(res.body);
          ProgressTrade result3=ProgressTrade.fromJson(cData3);
          signInController.getProgressTradeList=result3;    
            } catch (e) {
              if (kDebugMode) {
                print("error in getting progress contractor list");
                print(e);
              }
            }
      try {
     DateFormat dateFormat = DateFormat("yyyy-MM-dd");
     var getLabourAttendanceURL=Uri.parse('${Config.getLabourAttendanceApi}${dateFormat.format(DateTime.now())}/${signInController.getProjectData?.clientid.toString()}/$projectID');
        var res=await http.get(
            getLabourAttendanceURL,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            );
          Map<String,dynamic> cData3=jsonDecode(res.body);
          LabourAttendance result3=LabourAttendance.fromJson(cData3);
          signInController.getLabourAttendance=result3;    
          } catch (e) {
              if (kDebugMode) {
                print("error in getting labour attendance");
                print(e);
              }
          }
    try {
     var getEmployeesUrl=Uri.parse("${Config.getEmployees}$projectID");
        var res=await http.get(
            getEmployeesUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          ClientEmployee result4=ClientEmployee.fromJson(cData4['data']);
          signInController.getEmployeeList=result4;  
          // print(cData4['data'][0]['user_id']);  
            } catch (e) {
              if (kDebugMode) {
                print("error in getting employee list");
                print(e);
              }
            }
     update();
    } catch (e) {
      if (kDebugMode) {
        print('error in fetching user profile data!!!');
        print(e);
      }
       update();
    }
  }
}

class GetNewSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getSnagData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getSnagsUrl=Uri.parse("${Config.getSnagByStatusApi}$clientID/${projectID??"1"}/N/$isClient");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getSnagDataList=result5;
          
          if (kDebugMode) {
            print("Fetching new snag list");
          }
          update(); 
        } catch (e) {
          if (kDebugMode) {
            print("error in getting new snag list");
            print(e);
          }
        }
  }
}


class GetNewDeSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getSnagData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var id=sharedPreferences.getString('id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      isClient;
      try {
      var projectID=sharedPreferences.getString('projectIdd');
      var clientID=sharedPreferences.getString('client_id');
      var getSnagsUrl=Uri.parse("${Config.getDeSnagByStatusApi}$clientID/$projectID/N");
      var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getDeSnagDataList=result5;
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting new de snag list");
                print(e);
              }
            }
  }
}

class GetSnagsCount extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getSnagData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var id=sharedPreferences.getString('id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      isClient;
      try {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var token=sharedPreferences.getString('token');
     var res=await http.get(
            Uri.parse('${Config.getSnagsCount}$clientID/$projectID'),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            }
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagCount result5=SnagCount.fromJson(cData4);
          signInController.getSnagCount=result5;
          if (kDebugMode) {
            print("getting snag count");
          }
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting snag counts");
                print(e);
              }
            }
  }
}

class GetProgressCount extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getProgressData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var id=sharedPreferences.getString('id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      isClient;
      try {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var token=sharedPreferences.getString('token');
     var res=await http.get(
            Uri.parse('${Config.getProgressCount}$clientID/$projectID'),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            }
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          ProgressCount1 result5=ProgressCount1.fromJson(cData4);
          signInController.getProgressCount=result5;
          if (kDebugMode) {
            print("getting progress count");
          }
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting progress counts");
                print(e);
              }
            }
  }
}

class GetOpenedSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getOpenedSnagData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
       update(); 
      try {
      var getSnagsUrl=Uri.parse("${Config.getSnagByStatusApi}$clientID/${projectID??"1"}/O/$isClient");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
           update(); 
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getSnagDataOpenedList=result5;  
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in opened snag list");
                print(e);
              }
            }
  }
}

class GetOpenedDeSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getOpenedSnagData({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var id=sharedPreferences.getString('id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      isClient;
       update(); 
      try {
      var projectID=sharedPreferences.getString('projectIdd');
      var clientID=sharedPreferences.getString('client_id');
      var getSnagsUrl=Uri.parse("${Config.getDeSnagByStatusApi}$clientID/$projectID/O");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
           update(); 
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getDeSnagDataOpenedList=result5;  
          update(); 
            } catch (e) {
              if (kDebugMode) {
                print("error in opened de-snag list");
                print(e);
              }
            }
  }
}

class GetClosedSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getClosedSnagData({token, required BuildContext context}) async {
     final getClientProjectsController = Get.find<GetClientProject>();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     await getClientProjectsController.getSelectedProjects(context: context,selectedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getSnagsUrl=Uri.parse("${Config.getSnagByStatusApi}$clientID/${projectID??"1"}/C/$isClient");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getSnagDataClosedList=result5;
          update();   
            } catch (e) {
              if (kDebugMode) {
                print("error in getting closed snag list");
                print(e);
              }
            }
  }
}

class GetClosedDeSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getClosedSnagData({token, required BuildContext context}) async {
     final getClientProjectsController = Get.find<GetClientProject>();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     await getClientProjectsController.getSelectedProjects(context: context,selectedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
     var id=sharedPreferences.getString('id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      isClient;
      try {
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
      var getSnagsUrl=Uri.parse("${Config.getDeSnagByStatusApi}$clientID/$projectID/C");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getDeSnagDataClosedList=result5;
          print("))(((((((((");
          print(result5);
          update();   
            } catch (e) {
              if (kDebugMode) {
                print("error in getting closed snag list");
                print(e);
              }
            }
  }
}