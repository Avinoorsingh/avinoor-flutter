class ActivityHead {
  String? status;
  List<ACData>? data;

  ActivityHead({this.status, this.data});

  ActivityHead.fromJson(var json) {
     data =  [];
    for(var data1 in json){
      data?.add(ACData.fromJson(data1));    
      }
    // status = json['status'];
    // if (json['data'] != null) {
    //   data = [];
    //   json['data'].forEach((v) {
    //     data?.add(ACData.fromJson(v));
    //   });
    // }
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

class ACData {
  int? activityId;
  int? clientId;
  int? projectId;
  int? activityTypeId;
  String? activityHead;
  int? activityHeadOrder;
  int? import;
  String? description;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<SubActivity>? subActivity;

  ACData(
      {this.activityId,
      this.clientId,
      this.projectId,
      this.activityTypeId,
      this.activityHead,
      this.activityHeadOrder,
      this.import,
      this.description,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.subActivity});

  ACData.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    activityTypeId = json['activity_type_id'];
    activityHead = json['activity_head'];
    activityHeadOrder = json['activity_head_order'];
    import = json['import'];
    description = json['description'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subActivity'] != null) {
      subActivity = <SubActivity>[];
      json['subActivity'].forEach((v) {
        subActivity?.add(SubActivity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_id'] = activityId;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['activity_type_id'] = activityTypeId;
    data['activity_head'] = activityHead;
    data['activity_head_order'] = activityHeadOrder;
    data['import'] = import;
    data['description'] = description;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subActivity != null) {
      data['subActivity'] = subActivity?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubActivity {
  int? linkingActivityId;
  int? activityId;
  int? budgetId;
  String? activity;
  int? activityOrder;
  int? uomId;
  String? description;
  String? corel;
  int? locationId;
  int? subLocId;
  int? subSubLocId;
  int? status;
  int? import;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  SubActivity(
      {this.linkingActivityId,
      this.activityId,
      this.budgetId,
      this.activity,
      this.activityOrder,
      this.uomId,
      this.description,
      this.corel,
      this.locationId,
      this.subLocId,
      this.subSubLocId,
      this.status,
      this.import,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  SubActivity.fromJson(Map<String, dynamic> json) {
    linkingActivityId = json['linking_activity_id'];
    activityId = json['activity_id'];
    budgetId = json['budget_id'];
    activity = json['activity'];
    activityOrder = json['activity_order'];
    uomId = json['uom_id'];
    description = json['description'];
    corel = json['corel'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocId = json['sub_sub_loc_id'];
    status = json['status'];
    import = json['import'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['linking_activity_id'] = linkingActivityId;
    data['activity_id'] = activityId;
    data['budget_id'] = budgetId;
    data['activity'] = activity;
    data['activity_order'] = activityOrder;
    data['uom_id'] = uomId;
    data['description'] = description;
    data['corel'] = corel;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_loc_id'] = subSubLocId;
    data['status'] = status;
    data['import'] = import;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
