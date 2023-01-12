class QuantityForProgress {
  bool? success;
  QuantityForProgressData? data;

  QuantityForProgress({this.success, this.data});

  QuantityForProgress.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? QuantityForProgressData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class QuantityForProgressData {
  int? activityId;
  int? uomId;
  int? locationId;
  int? subLocId;
  int? subSubLocId;
  int? budgetId;
  int? issueStatus;
  int? revisionCode;
  int? linkingActivityId;
  String? locationName;
  String? subLocationName;
  String? subSubLocationName;
  String? activityHead;
  String? activity;
  int? quantityId;
  int? quantity;
  String? uomName;

  QuantityForProgressData(
      {this.activityId,
      this.uomId,
      this.locationId,
      this.subLocId,
      this.subSubLocId,
      this.budgetId,
      this.issueStatus,
      this.revisionCode,
      this.linkingActivityId,
      this.locationName,
      this.subLocationName,
      this.subSubLocationName,
      this.activityHead,
      this.activity,
      this.quantityId,
      this.quantity,
      this.uomName});

  QuantityForProgressData.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    uomId = json['uom_id'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocId = json['sub_sub_loc_id'];
    budgetId = json['budget_id'];
    issueStatus = json['issue_status'];
    revisionCode = json['revision_code'];
    linkingActivityId = json['linking_activity_id'];
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subSubLocationName = json['sub_sub_location_name'];
    activityHead = json['activity_head'];
    activity = json['activity'];
    quantityId = json['quantity_id'];
    quantity = json['quantity'];
    uomName = json['uom_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_id'] = activityId;
    data['uom_id'] = uomId;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_loc_id'] = subSubLocId;
    data['budget_id'] = budgetId;
    data['issue_status'] = issueStatus;
    data['revision_code'] = revisionCode;
    data['linking_activity_id'] = linkingActivityId;
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_sub_location_name'] = subSubLocationName;
    data['activity_head'] = activityHead;
    data['activity'] = activity;
    data['quantity_id'] = quantityId;
    data['quantity'] = quantity;
    data['uom_name'] = uomName;
    return data;
  }
}