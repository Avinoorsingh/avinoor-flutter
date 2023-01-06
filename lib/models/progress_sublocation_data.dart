class ProgressSubLocationData {
  bool? success;
  List<ProgressSubLocationListData>? data;

  ProgressSubLocationData({this.success, this.data});

  ProgressSubLocationData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProgressSubLocationListData>[];
      json['data'].forEach((v) {
        data!.add(ProgressSubLocationListData.fromJson(v));
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

class ProgressSubLocationListData {
  String? locationName;
  String? subLocationName;
  int? subLocId;

  ProgressSubLocationListData({this.locationName, this.subLocationName, this.subLocId});

  ProgressSubLocationListData.fromJson(Map<String, dynamic> json) {
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subLocId = json['sub_loc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_loc_id'] = subLocId;
    return data;
  }
}