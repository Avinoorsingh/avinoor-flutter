class DailyProgress {
  bool? success;
  List<DailyProgressData>? data;
  String? msg;

  DailyProgress({this.success, this.data, this.msg});

  DailyProgress.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DailyProgressData>[];
      json['data'].forEach((v) {
        data!.add(DailyProgressData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class DailyProgressData {
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
  // ignore: prefer_typing_uninitialized_variables
  var import;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? checklistId;
  int? checkStatus;
  int? triggerId;
  int? cmId;
  String? locationName;
  String? subLocationName;
  String? subSubLocationName;
  String? activityHead;
  String? uomName;
  int? dailyId;
  int? progressId;
  int? contractorId;
  int? cumulativeQuantity;
  double? achivedQuantity;
  int? totalQuantity;
  String? progressDate;
  int? progressPercentage;
  String? debetContactor;
  int? progType;
  String? remarks;
  int? draftStatus;
  int? id;
  int? clientId;
  int? projectId;
  int? type;
  int? linkActivityId;
  String? fileName;

  DailyProgressData(
      {
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
      this.updatedAt,
      this.checklistId,
      this.checkStatus,
      this.triggerId,
      this.cmId,
      this.locationName,
      this.subLocationName,
      this.subSubLocationName,
      this.activityHead,
      this.uomName,
      this.dailyId,
      this.progressId,
      this.contractorId,
      this.cumulativeQuantity,
      this.achivedQuantity,
      this.totalQuantity,
      this.progressDate,
      this.progressPercentage,
      this.debetContactor,
      this.progType,
      this.remarks,
      this.draftStatus,
      this.id,
      this.clientId,
      this.projectId,
      this.type,
      this.linkActivityId,
      this.fileName});

  DailyProgressData.fromJson(Map<String, dynamic> json) {
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
    checklistId = json['checklist_id'];
    checkStatus = json['check_status'];
    triggerId = json['trigger_id'];
    cmId = json['cm_id'];
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subSubLocationName = json['sub_sub_location_name'];
    activityHead = json['activity_head'];
    uomName = json['uom_name'];
    dailyId = json['daily_id'];
    progressId = json['progress_id'];
    contractorId = json['contractor_id'];
    cumulativeQuantity = json['cumulative_quantity'];
    achivedQuantity = json['achived_quantity'];
    totalQuantity = json['total_quantity'];
    progressDate = json['progress_date'];
    progressPercentage = json['progress_percentage'];
    debetContactor = json['debet_contactor'];
    progType = json['prog_type'];
    remarks = json['remarks'];
    draftStatus = json['draft_status'];
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    type = json['type'];
    linkActivityId = json['link_activity_id'];
    fileName = json['file_name'];
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
    data['checklist_id'] = checklistId;
    data['check_status'] = checkStatus;
    data['trigger_id'] = triggerId;
    data['cm_id'] = cmId;
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_sub_location_name'] = subSubLocationName;
    data['activity_head'] = activityHead;
    data['uom_name'] = uomName;
    data['daily_id'] = dailyId;
    data['progress_id'] = progressId;
    data['contractor_id'] = contractorId;
    data['cumulative_quantity'] = cumulativeQuantity;
    data['achived_quantity'] = achivedQuantity;
    data['total_quantity'] = totalQuantity;
    data['progress_date'] = progressDate;
    data['progress_percentage'] = progressPercentage;
    data['debet_contactor'] = debetContactor;
    data['prog_type'] = progType;
    data['remarks'] = remarks;
    data['draft_status'] = draftStatus;
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['type'] = type;
    data['link_activity_id'] = linkActivityId;
    data['file_name'] = fileName;
    return data;
  }
}