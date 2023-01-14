// ignore: file_names
class ProgressActivityHeadData {
  bool? success;
  List<ProgressActivityHeadDataList>? data;

  ProgressActivityHeadData({this.success, this.data});

  ProgressActivityHeadData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProgressActivityHeadDataList>[];
      json['data'].forEach((v) {
        data!.add(ProgressActivityHeadDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProgressActivityHeadDataList {
  String? activityHead;
  int? activityId;

  ProgressActivityHeadDataList({this.activityHead, this.activityId});

  ProgressActivityHeadDataList.fromJson(Map<String, dynamic> json) {
    activityHead = json['activity_head'];
    activityId = json['activity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_head'] = activityHead;
    data['activity_id'] = activityId;
    return data;
  }
}