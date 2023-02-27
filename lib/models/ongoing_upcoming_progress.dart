class OnGoingUpcomingProgress {
  bool? success;
  List<OnGoingUpcomingData>? data;

  OnGoingUpcomingProgress({this.success, this.data});

  OnGoingUpcomingProgress.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OnGoingUpcomingData>[];
      json['data'].forEach((v) {
        data!.add(OnGoingUpcomingData.fromJson(v));
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

class OnGoingUpcomingData {
  int? progressId;
  // ignore: prefer_typing_uninitialized_variables
  var quantity;
  int? quantityId;
  String? locationName;
  String? contractorName;
  String? subLocationName;
  String? uomName;
  String? subSubLocationName;
  String? activityHead;
  int? startTrigger;
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

  OnGoingUpcomingData(
      {this.progressId,
      this.quantity,
      this.quantityId,
      this.locationName,
      this.contractorName,
      this.subLocationName,
      this.uomName,
      this.subSubLocationName,
      this.activityHead,
      this.startTrigger,
      this.linkingActivityId,
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

  OnGoingUpcomingData.fromJson(Map<String, dynamic> json) {
    progressId = json['progress_id'];
    quantity = json['quantity'];
    quantityId = json['quantity_id'];
    locationName = json['location_name'];
    contractorName = json['contractor_name'];
    subLocationName = json['sub_location_name'];
    uomName=json['uom_name'];
    subSubLocationName = json['sub_sub_location_name'];
    activityHead = json['activity_head'];
    startTrigger = json['start_trigger'];
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
    data['progress_id'] = progressId;
    data['quantity'] = quantity;
    data['quantity_id'] = quantityId;
    data['location_name'] = locationName;
    data['contractor_name'] = contractorName;
    data['sub_location_name'] = subLocationName;
    data['uom_name']=uomName;
    data['sub_sub_location_name'] = subSubLocationName;
    data['activity_head'] = activityHead;
    data['start_trigger'] = startTrigger;
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