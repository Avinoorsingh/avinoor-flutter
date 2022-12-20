class ViewPointsApi {
  String? status;
  List<ViewPointData>? data;

  ViewPointsApi({this.status, this.data});

  ViewPointsApi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ViewPointData.fromJson(v));
      });
    }
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

class ViewPointData {
  int? viewpointNameId;
  String? fileName;
  int? fileNameId;
  String? viewpoint;
  String? masterFile;

  ViewPointData(
      {this.viewpointNameId,
      this.fileName,
      this.fileNameId,
      this.viewpoint,
      this.masterFile});

  ViewPointData.fromJson(Map<String, dynamic> json) {
    viewpointNameId = json['viewpoint_name_id'];
    fileName = json['file_name'];
    fileNameId = json['file_name_id'];
    viewpoint = json['viewpoint'];
    masterFile = json['master_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['viewpoint_name_id'] = viewpointNameId;
    data['file_name'] = fileName;
    data['file_name_id'] = fileNameId;
    data['viewpoint'] = viewpoint;
    data['master_file'] = masterFile;
    return data;
  }
}
