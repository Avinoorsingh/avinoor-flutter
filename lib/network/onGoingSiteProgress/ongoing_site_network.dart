import 'dart:convert';
import 'package:colab/models/ongoing_completed_progress_data.dart';
import 'package:colab/models/ongoing_upcoming_progress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../../controller/signInController.dart';
import '../../models/ongoing_ongoing_progress_data.dart';

class GetOnGoingDetail extends GetxController{
  Future getDetail({required cID,required pID, required locID, required subLocID, required subSubLocID, required pageNumber}) async {
     final signInController = Get.find<SignInController>();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
      try {
      var getDataUrl=Uri.parse(Config.getOnGoingOnGoingProgressApi);
        var res=await http.post(
            getDataUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
                "cid":cID,
                "pid":pID,
                "loc_id":locID,
                "sub_loc_id":subLocID,
                "sub_sub_loc_id":subSubLocID,
                "page_number":pageNumber
              }
          );
          var cData4=jsonDecode(res.body);
          OnGoingOnGoingProgress result=OnGoingOnGoingProgress.fromJson(cData4);
          signInController.getOnGoingOnGoingData=result;
          update();
            } catch (e) {
              if (kDebugMode) {
                print("error in on-going inside on-going data");
                print(e);
        }
    }
  }
}

class GetOnUpComingData extends GetxController{
  Future getDetail({required cID,required pID, required locID, required subLocID, required subSubLocID, required pageNumber}) async {
     final signInController = Get.find<SignInController>();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
      try {
      var getDataUrl=Uri.parse(Config.getOnGoingUpcomingProgressApi);
        var res=await http.post(
            getDataUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
                "cid":cID,
                "pid":pID,
                "loc_id":locID,
                "sub_loc_id":subLocID,
                "sub_sub_loc_id":subSubLocID,
                "page_number":pageNumber
              }
          );
          var cData4=jsonDecode(res.body);
          OnGoingUpcomingProgress result=OnGoingUpcomingProgress.fromJson(cData4);
          print("####################################");
          print(cData4);
          print("####################################");
          signInController.getOnGoingUpComingData=result;
          update();
            } catch (e) {
              if (kDebugMode) {
                print("error in on-going inside on-going data");
                print(e);
        }
    }
  }
}

class GetOnGoingCompletedDetail extends GetxController{
  Future getDetail({required cID,required pID, required locID, required subLocID, required subSubLocID, required pageNumber}) async {
     final signInController = Get.find<SignInController>();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
      try {
      var getDataUrl=Uri.parse(Config.getOnGoingCompletedProgressApi);
        var res=await http.post(
            getDataUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
                "cid":cID,
                "pid":pID,
                "loc_id":locID,
                "sub_loc_id":subLocID,
                "sub_sub_loc_id":subSubLocID,
                "page_number":pageNumber
            }
          );
          var cData4=jsonDecode(res.body);
          OnGoingCompletedProgress result5=OnGoingCompletedProgress.fromJson(cData4);
          signInController.getOnGoingCompletedData=result5;
          print(cData4);
            } catch (e) {
              if (kDebugMode) {
                print("error in completed data inside on-going");
                print(e);
        }
    }
  }
}