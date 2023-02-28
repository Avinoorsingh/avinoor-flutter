// ignore_for_file: file_names

class CompletedProgress {
  bool? success;
  List<CompletedProgressData>? data;

  CompletedProgress({this.success, this.data});

  CompletedProgress.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompletedProgressData>[];
      json['data'].forEach((v) {
        data!.add(CompletedProgressData.fromJson(v));
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

class CompletedProgressData {
  int? locationId;
  int? projectId;
  int? clientId;
  String? locationName;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? count;
  int? draftCount;

  CompletedProgressData(
      {this.locationId,
      this.projectId,
      this.clientId,
      this.locationName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.count,
      this.draftCount});

  CompletedProgressData.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    locationName = json['location_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
     count = json['count'];
    draftCount = json['draft_count'];
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