import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
// import 'package:get/get.dart' hide MultipartFile;
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';

class PhotosNetwork {
  var dio = Dio();
  final signInController = Get.find<SignInController>();
  Future uploadPhotos({dateInput,category,location,subLocation,subSubLocation,contractor,
  remark, debitTo, dueDate, debitAmount,snagAssignedTo,  snagPriority , imgPath, filename, webImage}) async {
    try {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        var token=sharedPreferences.getString('token');
       FormData formData=FormData(); 
       formData.fields.add(MapEntry('snags_data', jsonEncode({
                       "client_id": signInController.getProjectData?.clientid,
                      "project_id": "1",
                      "category_id": "4",
                      "location_id": '1',
                      "sub_loc_id": "1",
                      "sub_sub_loc_id": '3',
                      "activity_head_id": '1',
                      "activity_id": '1',
                      "contractor_id": '1',
                      'debet_contractor_id':'2',
                      "remark": "remark",
                      "debit_note": "this is debit note",
                      "debit_amount": 100,
                      "due_date": dateInput,
                      "assigned_to": 12,
                      "created_by": 23,
                      "snag_status": "open",
                      "snag_priority":'MA',
        })));
         var response = await dio.post(
      "http://nodejs.hackerkernel.com/colab/api/add_snags",
      data: formData,
      options: Options(
         followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "authorization": "Bearer ${token!}",
          "Content-type": "application/json",
        },
      ),
         );
      // final response = await APIService.postJwtForm(
      //     url:  "http://nodejs.hackerkernel.com/colab/api/add_snags",
      //     body: {
      //       'snags_data':{
      //                 "client_id": "1",
      //                 "project_id": "1",
      //                 "category_id": "4",
      //                 "location_id": '1',
      //                 "sub_loc_id": "1",
      //                 "sub_sub_loc_id": '3',
      //                 "activity_head_id": '1',
      //                 "activity_id": '1',
      //                 "contractor_id": '1',
      //                 'debet_contractor_id':'2',
      //                 "remark": "remark",
      //                 "debit_note": "this is debit note",
      //                 "debit_amount": 100,
      //                 "due_date": "10/12/2022",
      //                 "assigned_to": 12,
      //                 "created_by": 23,
      //                 "snag_status": "open",
      //                 "snag_priority":'MA',
      //              }
      //   // "file": imgPath != null
      //   //         ? await MultipartFile.fromFile(imgPath, filename: filename)
      //   //         : (webImage != null && kIsWeb)
      //   //             ? MultipartFile.fromBytes(webImage)
      //   //             : null,
      //     },
      //     token: token!);
      return response;
    } catch (e) {
      EasyLoading.dismiss();
      if (kDebugMode) {
        print('nhi hui upload');
           print(e);
      }
    }
  }
}