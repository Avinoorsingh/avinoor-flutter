class QualitySubSubLocationList {
  bool? success;
  List<QualityCheckListSubSubLocationData>? data;

  QualitySubSubLocationList({this.success, this.data});

  QualitySubSubLocationList.fromJson(var json) {
    data =  [];
    for(var data1 in json){
      data?.add(QualityCheckListSubSubLocationData.fromJson(data1));    
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

class QualityCheckListSubSubLocationData {
  String? subLocationName;
  int? subLocationId;
  String? subSubLocationName;

  QualityCheckListSubSubLocationData({this.subLocationName, this.subLocationId, this.subSubLocationName});

  QualityCheckListSubSubLocationData.fromJson(Map<String, dynamic> json) {
    subLocationName = json['sub_location_name'];
    subLocationId = json['sub_location_id'];
    subSubLocationName = json['sub_sub_location_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_location_name'] = subLocationName;
    data['sub_location_id'] = subLocationId;
    data['sub_sub_location_name'] = subSubLocationName;
    return data;
  }
}