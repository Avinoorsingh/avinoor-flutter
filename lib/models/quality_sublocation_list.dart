class QualitySubLocationList {
  bool? success;
  List<QualityCheckListSubLocationData>? data;

  QualitySubLocationList({this.success, this.data});

  QualitySubLocationList.fromJson(var json) {
     data =  [];
    for(var data1 in json){
      data?.add(QualityCheckListSubLocationData.fromJson(data1));    
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

class QualityCheckListSubLocationData {
  String? locationName;
  String? subLocationName;
  int? subLocationId;

  QualityCheckListSubLocationData(
      {this.locationName,
      this.subLocationName,
      this.subLocationId,
     });

  QualityCheckListSubLocationData.fromJson(Map<String, dynamic> json) {
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subLocationId = json['sub_loc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_loc_id'] = subLocationId;
    return data;
  }
}