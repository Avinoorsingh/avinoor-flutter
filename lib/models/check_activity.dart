class CheckActivity {
  bool? success;
  List<CheckActivityData>? data;

  CheckActivity({this.success, this.data});

  CheckActivity.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CheckActivityData>[];
      json['data'].forEach((v) {
        data!.add(CheckActivityData.fromJson(v));
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

class CheckActivityData {
  String? activity;
  String? activityHead;
  int? checkSecId;
  int? checkSecLinkId;
  int? id;
  int? clientId;
  int? projectId;
  String? checklistId;
  String? description;
  int? category;
  int? triggerId;
  int? activityHeadId;
  int? activityId;
  // ignore: prefer_typing_uninitialized_variables
  var upload;
  int? status;
  // ignore: prefer_typing_uninitialized_variables
  var import;
  // ignore: prefer_typing_uninitialized_variables
  var scheduledTime;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  CheckActivityData(
      {this.activity,
      this.activityHead,
      this.checkSecId,
      this.checkSecLinkId,
      this.id,
      this.clientId,
      this.projectId,
      this.checklistId,
      this.description,
      this.category,
      this.triggerId,
      this.activityHeadId,
      this.activityId,
      this.upload,
      this.status,
      this.import,
      this.scheduledTime,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  CheckActivityData.fromJson(Map<String, dynamic> json) {
    activity = json['activity'];
    activityHead = json['activity_head'];
    checkSecId = json['check_sec_id'];
    checkSecLinkId = json['check_sec_link_id'];
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    checklistId = json['checklist_id'];
    description = json['description'];
    category = json['category'];
    triggerId = json['trigger_id'];
    activityHeadId = json['activity_head_id'];
    activityId = json['activity_id'];
    upload = json['upload'];
    status = json['status'];
    import = json['import'];
    scheduledTime = json['scheduled_time'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity'] = activity;
    data['activity_head'] = activityHead;
    data['check_sec_id'] = checkSecId;
    data['check_sec_link_id'] = checkSecLinkId;
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['checklist_id'] = checklistId;
    data['description'] = description;
    data['category'] = category;
    data['trigger_id'] = triggerId;
    data['activity_head_id'] = activityHeadId;
    data['activity_id'] = activityId;
    data['upload'] = upload;
    data['status'] = status;
    data['import'] = import;
    data['scheduled_time'] = scheduledTime;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}