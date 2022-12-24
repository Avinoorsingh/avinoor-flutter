class ManualCheckList {
  bool? success;
  List<ManaulCheckListData>? data;

  ManualCheckList({this.success, this.data});

  ManualCheckList.fromJson(var json) {
     data =  [];
    for(var data1 in json){
      data?.add(ManaulCheckListData.fromJson(data1));    
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

class ManaulCheckListData {
  int? sectionId;
  int? sectionLinkId;
  int? activityHead;
  String? activity;
  int? id;
  int? clientId;
  int? projectId;
  String? checklistId;
  String? description;
  int? category;
  int? triggerId;
  int? activityHeadId;
  int? activityId;
  String? upload;
  String? status;
  String? import;
  String? scheduledTime;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  ManaulCheckListData(
      {this.sectionId,
      this.sectionLinkId,
      this.activityHead,
      this.activity,
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

  ManaulCheckListData.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    sectionLinkId = json['section_link_id'];
    activityHead = json['activity_head'];
    activity = json['activity'];
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
    data['section_id'] = sectionId;
    data['section_link_id'] = sectionLinkId;
    data['activity_head'] = activityHead;
    data['activity'] = activity;
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