class QualityActivityHead {
  bool? success;
  List<QualityActivityHeadData>? data;

  QualityActivityHead({this.success, this.data});

  QualityActivityHead.fromJson(var json){
    data =  [];
    for(var data1 in json){
      data?.add(QualityActivityHeadData.fromJson(data1));    
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

class QualityActivityHeadData {
  String? activityHead;
  int? activityId;

  QualityActivityHeadData({this.activityHead, this.activityId});

  QualityActivityHeadData.fromJson(Map<String, dynamic> json) {
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