import 'package:flutter/foundation.dart';

class ClientEmployee {
  bool? success;
  List<EmployeeData>? data;

  ClientEmployee({this.success, this.data});

  ClientEmployee.fromJson(var json) {
    data =  [];
    if(json!=null){
    for(var data1 in json){
      try {
      data?.add(EmployeeData.fromJson(data1)); 
      } catch (e) {
        if (kDebugMode) {
          print("error is here!");
             print(e);
        }
      }   
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeData {
  String? userId;
  int? id;

  EmployeeData({this.userId, this.id});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['id'] = id;
    return data;
  }
}
