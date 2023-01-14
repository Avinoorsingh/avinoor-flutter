class LabourAttendance {
  bool? success;
  List<Data>? data;
  List<MainData>? mainData;

  LabourAttendance({this.success, this.data, this.mainData});

  LabourAttendance.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['mainData'] != null) {
      mainData = <MainData>[];
      json['mainData'].forEach((v) {
        mainData!.add(MainData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (mainData != null) {
      data['mainData'] = mainData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? clientId;
  int? projectId;
  int? contractorId;
  int? contractorLabourLinkingId;
  String? inTime;
  String? labourDate;
  // ignore: prefer_typing_uninitialized_variables
  var outTime;
  int? workingHours;
  String? ot;
  String? createdAt;
  String? updatedAt;
  String? contactNo;
  String? contractorName;
  int? workingHrs;
  String? name;
  int? rate;
  int? otRate;
  String? aadhar;

  Data(
      {this.id,
      this.clientId,
      this.projectId,
      this.contractorId,
      this.contractorLabourLinkingId,
      this.inTime,
      this.labourDate,
      this.outTime,
      this.workingHours,
      this.ot,
      this.createdAt,
      this.updatedAt,
      this.contactNo,
      this.contractorName,
      this.workingHrs,
      this.name,
      this.rate,
      this.otRate,
      this.aadhar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    contractorId = json['contractor_id'];
    contractorLabourLinkingId = json['contractor_labour_linking_id'];
    inTime = json['in_time'];
    labourDate = json['labour_date'];
    outTime = json['out_time'];
    workingHours = json['working_hours'];
    ot = json['ot'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contactNo = json['contact_no'];
    contractorName = json['contractor_name'];
    workingHrs = json['working_hrs'];
    name = json['name'];
    rate = json['rate'];
    otRate = json['ot_rate'];
    aadhar = json['aadhar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['contractor_id'] = contractorId;
    data['contractor_labour_linking_id'] = contractorLabourLinkingId;
    data['in_time'] = inTime;
    data['labour_date'] = labourDate;
    data['out_time'] = outTime;
    data['working_hours'] = workingHours;
    data['ot'] = ot;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['contact_no'] = contactNo;
    data['contractor_name'] = contractorName;
    data['working_hrs'] = workingHrs;
    data['name'] = name;
    data['rate'] = rate;
    data['ot_rate'] = otRate;
    data['aadhar'] = aadhar;
    return data;
  }
}

class MainData {
  int? id;
  String? contractorName;
  List<Data>? labourDetails;

  MainData({this.id, this.contractorName, this.labourDetails});

  MainData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractorName = json['contractor_name'];
    if (json['labourDetails'] != null) {
      labourDetails = <Data>[];
      json['labourDetails'].forEach((v) {
        labourDetails!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contractor_name'] = contractorName;
    if (labourDetails != null) {
      data['labourDetails'] =
          labourDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}