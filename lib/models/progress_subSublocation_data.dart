// ignore: file_names
class ProgressSubSubLocationData {
  bool? success;
  List<ProgressSubSubLocationListData>? data;

  ProgressSubSubLocationData({this.success, this.data});

  ProgressSubSubLocationData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProgressSubSubLocationListData>[];
      json['data'].forEach((v) {
        data!.add(ProgressSubSubLocationListData.fromJson(v));
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

class ProgressSubSubLocationListData {
  String? subLocationName;
  int? subLocationId;
  String? subSubLocationName;

  ProgressSubSubLocationListData({this.subLocationName, this.subLocationId, this.subSubLocationName});

  ProgressSubSubLocationListData.fromJson(Map<String, dynamic> json) {
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