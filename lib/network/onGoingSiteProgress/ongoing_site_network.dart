
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colab/models/section_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../../controller/signInController.dart';

class GetOnGoingDetail{
  Future getDetail({required cID,required pID, required locID, required subLocID, required subSubLocID, required pageNumber}) async {
     final signInController = Get.find<SignInController>();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
      try {
      var getDataUrl=Uri.parse(Config.getOnGoingProgressApi);
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
          SectionDetail result5=SectionDetail.fromJson(cData4['data']);
          signInController.getSectionData=result5;
            } catch (e) {
              if (kDebugMode) {
                print("error in on-section data");
                print(e);
        }
    }
  }
}