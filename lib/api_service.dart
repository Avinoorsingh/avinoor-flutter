import 'dart:convert';
import 'package:colab/config.dart';
import 'package:colab/models/login_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'models/client_response.dart';

class APIService{
  static var client=http.Client();
  List clientData=[];
  static Future<String> login(LoginUserModel model) async{
    var clientData= <ClientProfileData>[];
    Map<String, String> requestHeaders={
      'Content-Type':'application/json',
    };
    var url=Uri.parse(Config.loginApi);
    var getUserDataUrl=Uri.parse(Config.getUserDataApi);
    var response=await client.post(
    url, 
    headers: requestHeaders,
    body: jsonEncode(model.toJson()));
    if(response.statusCode==200){
      Map<String, dynamic> responseSuccess=jsonDecode(response.body);
      if (kDebugMode) {
        print(responseSuccess);
      }
      if(responseSuccess['success']==true){
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var tokenValue=responseSuccess['token'];
          var name=responseSuccess['data']['name'];
          var updatedAt=responseSuccess['data']['updated_at'];
          var clientId=responseSuccess['data']['client_id'].toString();
          var id=responseSuccess['data']['id'].toString();
          sharedPreferences.setString('token', tokenValue);
          sharedPreferences.setString('client_id',clientId);
          sharedPreferences.setString('id',id);
          sharedPreferences.setString('name',name);
          sharedPreferences.setString('updated_at',updatedAt);
        if(responseSuccess['data']['user_id']=='superadmin'){
          return "superadmin";
        }
        else{
          var res=await http.get(
            getUserDataUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer ${responseSuccess['token']}",
              'client_id':responseSuccess['data']['client_id'].toString(),
              'id':responseSuccess['data']['id'].toString(),
            }
            );

           Map<String, dynamic> resSuccess=jsonDecode(res.body);
           if(resSuccess['data'].length>1){
             for(var data in  resSuccess['data']){
            clientData.add(ClientProfileData.fromJson(data));
           }
           if (kDebugMode) {
             print(clientData);
           }
            return "clientLevel";
           }
           else if(resSuccess['data'].length<=1){
            if(resSuccess['dataRes']==false){
              return "projectLevel";
           }
           else if(resSuccess['projectCount']==1){
            return "clientLevel";
           }
           else{
            return "rolesAndResponsibilities";
           }
           }
           else{
        return "";
           }
        }
      }
      else{
        return "false";
      }
    }else{
      return "false";
    }
  }

static Future postJwtForm({
    String? url,
    Map<String, dynamic> body = const {},
    String? token,
  }) async {
    var dio = Dio();
    var formData = FormData.fromMap(body);
    if (kDebugMode) {
      print(body);
    }
    try {
    var response = await dio.post(
      url!,
      data: formData,
      options: Options(
         followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "authorization": "Bearer ${token!}",
          // "Content-Type": "multipart/form-data",
          // "Content-Length": "<calculated when request is sent>",
          "Content-type": "application/json",
        },
      ),
    );
    return {'status': response.statusCode, 'body': response.data};
    } catch (e) {
      print("///////////////");
      print(e);
    }
  }
}