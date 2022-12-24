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
  int? locationId;
  int? projectId;
  int? clientId;
  String? locationName;
  String? createdAt;
  Null? updatedAt;
  Null? createdBy;
  Null? updatedBy;

  QualityCheckListSubLocationData(
      {this.locationId,
      this.projectId,
      this.clientId,
      this.locationName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  QualityCheckListSubLocationData.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    locationName = json['location_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['project_id'] = projectId;
    data['client_id'] = clientId;
    data['location_name'] = locationName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    return data;
  }
}