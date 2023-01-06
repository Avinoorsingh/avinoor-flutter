class ProgressListAll {
  bool? success;
  List<ProgressListAllData>? data;

  ProgressListAll({this.success, this.data});

  ProgressListAll.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProgressListAllData>[];
      json['data'].forEach((v) {
        data!.add(ProgressListAllData.fromJson(v));
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

class ProgressListAllData {
  int? checklistId;
  int? checkStatus;
  int? triggerId;
  int? cmId;
  String? locationName;
  String? subLocationName;
  String? subSubLocationName;
  String? activity;
  String? activityHead;
  int? dailyId;
  int? draftStatus;
  int? progressId;
  int? progressPercentage;
  int? id;
  int? clientId;
  int? projectId;
  int? type;
  int? linkActivityId;
  int? contractorId;
  int? debetContactor;
  String? remarks;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  ProgressListAllData(
      {this.checklistId,
      this.checkStatus,
      this.triggerId,
      this.cmId,
      this.locationName,
      this.subLocationName,
      this.subSubLocationName,
      this.activity,
      this.activityHead,
      this.dailyId,
      this.draftStatus,
      this.progressId,
      this.progressPercentage,
      this.id,
      this.clientId,
      this.projectId,
      this.type,
      this.linkActivityId,
      this.contractorId,
      this.debetContactor,
      this.remarks,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  ProgressListAllData.fromJson(Map<String, dynamic> json) {
    checklistId = json['checklist_id'];
    checkStatus = json['check_status'];
    triggerId = json['trigger_id'];
    cmId = json['cm_id'];
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subSubLocationName = json['sub_sub_location_name'];
    activity = json['activity'];
    activityHead = json['activity_head'];
    dailyId = json['daily_id'];
    draftStatus = json['draft_status'];
    progressId = json['progress_id'];
    progressPercentage = json['progress_percentage'];
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    type = json['type'];
    linkActivityId = json['link_activity_id'];
    contractorId = json['contractor_id'];
    debetContactor = json['debet_contactor'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checklist_id'] = checklistId;
    data['check_status'] = checkStatus;
    data['trigger_id'] = triggerId;
    data['cm_id'] = cmId;
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_sub_location_name'] = subSubLocationName;
    data['activity'] = activity;
    data['activity_head'] = activityHead;
    data['daily_id'] = dailyId;
    data['draft_status'] = draftStatus;
    data['progress_id'] = progressId;
    data['progress_percentage'] = progressPercentage;
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['type'] = type;
    data['link_activity_id'] = linkActivityId;
    data['contractor_id'] = contractorId;
    data['debet_contactor'] = debetContactor;
    data['remarks'] = remarks;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}