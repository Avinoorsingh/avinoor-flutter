class SubLocationList {
  String? status;
  List<SubLocationData>? data;

  SubLocationList({this.status, this.data});

  SubLocationList.fromJson(var json) {
    data =  [];
    print(json);
    for(var data1 in json){
      data?.add(SubLocationData.fromJson(data1));    
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubLocationData {
  int? subLocId;
  int? locationId;
  int? projectId;
  int? clientId;
  int? orderNo;
  String? subLocationName;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<SubSubLocationInfo>? subSubLocationInfo;

  SubLocationData(
      {this.subLocId,
      this.locationId,
      this.projectId,
      this.clientId,
      this.orderNo,
      this.subLocationName,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.subSubLocationInfo});

  SubLocationData.fromJson(Map<String, dynamic> json) {
    subLocId = json['sub_loc_id'];
    locationId = json['location_id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    orderNo = json['order_no'];
    subLocationName = json['sub_location_name'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subSubLocationInfo'] != null) {
      subSubLocationInfo = <SubSubLocationInfo>[];
      json['subSubLocationInfo'].forEach((v) {
        subSubLocationInfo?.add(SubSubLocationInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_loc_id'] = subLocId;
    data['location_id'] = locationId;
    data['project_id'] = projectId;
    data['client_id'] = clientId;
    data['order_no'] = orderNo;
    data['sub_location_name'] = subLocationName;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subSubLocationInfo != null) {
      data['subSubLocationInfo'] =
          subSubLocationInfo?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSubLocationInfo {
  int? subLocationId;
  int? clientId;
  int? projectId;
  int? locationId;
  int? subLocId;
  String? subSubLocationName;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  SubSubLocationInfo(
      {this.subLocationId,
      this.clientId,
      this.projectId,
      this.locationId,
      this.subLocId,
      this.subSubLocationName,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  SubSubLocationInfo.fromJson(var json) {
    subLocationId = json['sub_location_id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocationName = json['sub_sub_location_name'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_location_id'] = subLocationId;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_location_name'] = subSubLocationName;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
