class AreaOfConcern {
  bool? success;
  List<AreaOfConcernData>? data;
  int? pending;
  int? resolved;
  int? read;
  int? allCount;

  AreaOfConcern(
      {this.success,
      this.data,
      this.pending,
      this.resolved,
      this.read,
      this.allCount});

  AreaOfConcern.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AreaOfConcernData>[];
      json['data'].forEach((v) {
        data!.add(AreaOfConcernData.fromJson(v));
      });
    }
    pending = json['pending'];
    resolved = json['resolved'];
    read = json['read'];
    allCount = json['allCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['pending'] = pending;
    data['resolved'] = resolved;
    data['read'] = read;
    data['allCount'] = allCount;
    return data;
  }
}

class AreaOfConcernData {
  int? id;
  int? clientId;
  int? projectId;
  int? issuerId;
  int? assignedTo;
  String? issueDate;
  int? locationId;
  int? subLocationId;
  int? subSubLocationId;
  int? activityId;
  int? linkingActivityId;
  String? otherLocation;
  String? description;
  // ignore: prefer_typing_uninitialized_variables
  var file;
  String? status;
  String? remark;
  String? createdAt;
  String? updatedAt;
  String? activity;
  String? activityHead;
  String? locationName;
  String? subLocationName;
  String? subSubLocationName;
  String? assigneeName;
  String? issuerName;

  AreaOfConcernData(
      {
      this.id,
      this.clientId,
      this.projectId,
      this.issuerId,
      this.assignedTo,
      this.issueDate,
      this.locationId,
      this.subLocationId,
      this.subSubLocationId,
      this.activityId,
      this.linkingActivityId,
      this.otherLocation,
      this.description,
      this.file,
      this.status,
      this.remark,
      this.createdAt,
      this.updatedAt,
      this.activity,
      this.activityHead,
      this.locationName,
      this.subLocationName,
      this.subSubLocationName,
      this.assigneeName,
      this.issuerName
      });

  AreaOfConcernData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    issuerId = json['issuer_id'];
    assignedTo = json['assigned_to'];
    issueDate = json['issue_date'];
    locationId = json['location_id'];
    subLocationId = json['sub_location_id'];
    subSubLocationId = json['sub_sub_location_id'];
    activityId = json['activity_id'];
    linkingActivityId = json['linking_activity_id'];
    otherLocation = json['other_location'];
    description = json['description'];
    file = json['file'];
    status = json['status'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    activity = json['activity'];
    activityHead = json['activity_head'];
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subSubLocationName = json['sub_sub_location_name'];
    assigneeName = json['assignee_name'];
    issuerName = json['issuer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['issuer_id'] = issuerId;
    data['assigned_to'] = assignedTo;
    data['issue_date'] = issueDate;
    data['location_id'] = locationId;
    data['sub_location_id'] = subLocationId;
    data['sub_sub_location_id'] = subSubLocationId;
    data['activity_id'] = activityId;
    data['linking_activity_id'] = linkingActivityId;
    data['other_location'] = otherLocation;
    data['description'] = description;
    data['file'] = file;
    data['status'] = status;
    data['remark'] = remark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['activity'] = activity;
    data['activity_head'] = activityHead;
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_sub_location_name'] = subSubLocationName;
    data['assignee_name'] = assigneeName;
    data['issuer_name'] = issuerName;
    return data;
  }
}