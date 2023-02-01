class ProgressOffline {
  List<ProgressOfflineData>? data;

  ProgressOffline({this.data});

  ProgressOffline.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProgressOfflineData>[];
      json['data'].forEach((v) {
        data!.add(ProgressOfflineData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProgressOfflineData {
  int? locationId;
  String? locationName;
  List<SubLocationInfo>? subLocationInfo;

  ProgressOfflineData({this.locationId, this.locationName, this.subLocationInfo});

  ProgressOfflineData.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    locationName = json['location_name'];
    if (json['subLocationInfo'] != null) {
      subLocationInfo = <SubLocationInfo>[];
      json['subLocationInfo'].forEach((v) {
        subLocationInfo!.add(SubLocationInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['location_name'] = locationName;
    if (subLocationInfo != null) {
      data['subLocationInfo'] =
          subLocationInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubLocationInfo {
  int? subLocId;
  String? subLocationName;
  List<SubSubLocationInfo>? subSubLocationInfo;

  SubLocationInfo(
      {this.subLocId, this.subLocationName, this.subSubLocationInfo});

  SubLocationInfo.fromJson(Map<String, dynamic> json) {
    subLocId = json['sub_loc_id'];
    subLocationName = json['sub_location_name'];
    if (json['subSubLocationInfo'] != null) {
      subSubLocationInfo = <SubSubLocationInfo>[];
      json['subSubLocationInfo'].forEach((v) {
        subSubLocationInfo!.add(SubSubLocationInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_loc_id'] = subLocId;
    data['sub_location_name'] = subLocationName;
    if (subSubLocationInfo != null) {
      data['subSubLocationInfo'] =
          subSubLocationInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSubLocationInfo {
  String? subSubLocationName;
  int? subLocationId;
  List<SubSubLocationActivity>? subSubLocationActivity;

  SubSubLocationInfo(
      {this.subSubLocationName,
      this.subLocationId,
      this.subSubLocationActivity});

  SubSubLocationInfo.fromJson(Map<String, dynamic> json) {
    subSubLocationName = json['sub_sub_location_name'];
    subLocationId = json['sub_location_id'];
    if (json['subSubLocationActivity'] != null) {
      subSubLocationActivity = <SubSubLocationActivity>[];
      json['subSubLocationActivity'].forEach((v) {
        subSubLocationActivity!.add(SubSubLocationActivity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_sub_location_name'] = subSubLocationName;
    data['sub_location_id'] = subLocationId;
    if (subSubLocationActivity != null) {
      data['subSubLocationActivity'] =
          subSubLocationActivity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSubLocationActivity {
  int? linkingActivityId;
  String? activity;
  double? quantity;
  int? productivity;
  List<ContractorName>? contractorName;
  ProjectActivityOne? projectActivityOne;
  ProgressAdd? progressAdd;

  SubSubLocationActivity(
      {this.linkingActivityId,
      this.activity,
      this.quantity,
      this.productivity,
      this.contractorName,
      this.projectActivityOne,
      this.progressAdd});

  SubSubLocationActivity.fromJson(Map<String, dynamic> json) {
    linkingActivityId = json['linking_activity_id'];
    activity = json['activity'];
    quantity = json['quantity'];
    productivity = json['productivity'];
    if (json['ContractorName'] != null) {
      contractorName = <ContractorName>[];
      json['ContractorName'].forEach((v) {
        contractorName!.add(ContractorName.fromJson(v));
      });
    }
    projectActivityOne = json['projectActivityOne'] != null
        ? ProjectActivityOne.fromJson(json['projectActivityOne'])
        : null;
    progressAdd = json['progressAdd'] != null
        ? ProgressAdd.fromJson(json['progressAdd'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['linking_activity_id'] = linkingActivityId;
    data['activity'] = activity;
    data['quantity'] = quantity;
    data['productivity'] = productivity;
    if (contractorName != null) {
      data['ContractorName'] =
          contractorName!.map((v) => v.toJson()).toList();
    }
    if (projectActivityOne != null) {
      data['projectActivityOne'] = projectActivityOne!.toJson();
    }
    if (progressAdd != null) {
      data['progressAdd'] = progressAdd!.toJson();
    }
    return data;
  }
}

class ContractorName {
  int? id;
  int? clientId;
  int? linkingActivityId;
  int? projectId;
  int? lineItemId;
  int? locationId;
  int? subLocId;
  int? subSubLocId;
  int? quantityId;
  String? createdAt;
  String? updatedAt;
  String? contractorName;

  ContractorName(
      {this.id,
      this.clientId,
      this.linkingActivityId,
      this.projectId,
      this.lineItemId,
      this.locationId,
      this.subLocId,
      this.subSubLocId,
      this.quantityId,
      this.createdAt,
      this.updatedAt,
      this.contractorName});

  ContractorName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    linkingActivityId = json['linking_activity_id'];
    projectId = json['project_id'];
    lineItemId = json['line_item_id'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocId = json['sub_sub_loc_id'];
    quantityId = json['quantity_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contractorName = json['contractor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['linking_activity_id'] = linkingActivityId;
    data['project_id'] = projectId;
    data['line_item_id'] = lineItemId;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_loc_id'] = subSubLocId;
    data['quantity_id'] = quantityId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['contractor_name'] = contractorName;
    return data;
  }
}

class ProjectActivityOne {
  String? activityHead;

  ProjectActivityOne({this.activityHead});

  ProjectActivityOne.fromJson(Map<String, dynamic> json) {
    activityHead = json['activity_head'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_head'] = activityHead;
    return data;
  }
}

class ProgressAdd {
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
  int? progressPercentage;
  double? commulativeQuantity;
  EmployeeInfo? employeeInfo;
  List<ProgressDailyInfo>? progressDailyInfo;

  ProgressAdd(
      {this.id,
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
      this.updatedAt,
      this.progressPercentage,
      this.commulativeQuantity,
      this.employeeInfo,
      this.progressDailyInfo});

  ProgressAdd.fromJson(Map<String, dynamic> json) {
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
    progressPercentage = json['progress_percentage'];
    commulativeQuantity = json['commulative_quantity'];
    employeeInfo = json['employeeInfo'] != null
        ? EmployeeInfo.fromJson(json['employeeInfo'])
        : null;
    if (json['progressDailyInfo'] != null) {
      progressDailyInfo = <ProgressDailyInfo>[];
      json['progressDailyInfo'].forEach((v) {
        progressDailyInfo!.add(ProgressDailyInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['progress_percentage'] = progressPercentage;
    data['commulative_quantity'] = commulativeQuantity;
    if (employeeInfo != null) {
      data['employeeInfo'] = employeeInfo!.toJson();
    }
    if (progressDailyInfo != null) {
      data['progressDailyInfo'] =
          progressDailyInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeInfo {
  int? id;
  int? clientId;
  String? userId;
  String? password;
  String? name;
  String? rm;
  String? mobileNo;
  String? emailId;
  int? roleId;
  int? status;
  int? userType;
  String? lastName;
  int? designation;
  String? altMobileNo;
  String? emergencyName;
  String? emergencyMobileNo;
  String? dob;
  String? doj;
  String? userImage;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  EmployeeInfo(
      {this.id,
      this.clientId,
      this.userId,
      this.password,
      this.name,
      this.rm,
      this.mobileNo,
      this.emailId,
      this.roleId,
      this.status,
      this.userType,
      this.lastName,
      this.designation,
      this.altMobileNo,
      this.emergencyName,
      this.emergencyMobileNo,
      this.dob,
      this.doj,
      this.userImage,
      this.fcmToken,
      this.createdAt,
      this.updatedAt});

  EmployeeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    userId = json['user_id'];
    password = json['password'];
    name = json['name'];
    rm = json['rm'];
    mobileNo = json['mobile_no'];
    emailId = json['email_id'];
    roleId = json['role_id'];
    status = json['status'];
    userType = json['user_type'];
    lastName = json['last_name'];
    designation = json['designation'];
    altMobileNo = json['alt_mobile_no'];
    emergencyName = json['emergency_name'];
    emergencyMobileNo = json['emergency_mobile_no'];
    dob = json['dob'];
    doj = json['doj'];
    userImage = json['user_image'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['user_id'] = userId;
    data['password'] = password;
    data['name'] = name;
    data['rm'] = rm;
    data['mobile_no'] = mobileNo;
    data['email_id'] = emailId;
    data['role_id'] = roleId;
    data['status'] = status;
    data['user_type'] = userType;
    data['last_name'] = lastName;
    data['designation'] = designation;
    data['alt_mobile_no'] = altMobileNo;
    data['emergency_name'] = emergencyName;
    data['emergency_mobile_no'] = emergencyMobileNo;
    data['dob'] = dob;
    data['doj'] = doj;
    data['user_image'] = userImage;
    data['fcm_token'] = fcmToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProgressDailyInfo {
  int? dailyId;
  int? progressId;
  int? contractorId;
  double? cumulativeQuantity;
  double? achivedQuantity;
  double? totalQuantity;
  String? progressDate;
  int? progressPercentage;
  int? debetContactor;
  int? progType;
  String? remarks;
  int? draftStatus;
  String? createdAt;
  String? updatedAt;
  DebitContractor? debitContractor;
  ProgressImagebyDaily? progressImagebyDaily;
  List<ProgressLabourLinkings>? progressLabourLinkings;
  List<ProgressContByPwr>? progressContByPwr;

  ProgressDailyInfo(
      {this.dailyId,
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
      this.createdAt,
      this.updatedAt,
      this.debitContractor,
      this.progressImagebyDaily,
      this.progressLabourLinkings,
      this.progressContByPwr});

  ProgressDailyInfo.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    debitContractor = json['debitContractor'] != null
        ? DebitContractor.fromJson(json['debitContractor'])
        : null;
    progressImagebyDaily = json['progressImagebyDaily'] != null
        ? ProgressImagebyDaily.fromJson(json['progressImagebyDaily'])
        : null;
    if (json['progressLabourLinkings'] != null) {
      progressLabourLinkings = <ProgressLabourLinkings>[];
      json['progressLabourLinkings'].forEach((v) {
        progressLabourLinkings!.add(ProgressLabourLinkings.fromJson(v));
      });
    }
    if (json['progressContByPwr'] != null) {
      progressContByPwr = <ProgressContByPwr>[];
      json['progressContByPwr'].forEach((v) {
        progressContByPwr!.add(ProgressContByPwr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (debitContractor != null) {
      data['debitContractor'] = debitContractor!.toJson();
    }
    if (progressImagebyDaily != null) {
      data['progressImagebyDaily'] = progressImagebyDaily!.toJson();
    }
    if (progressLabourLinkings != null) {
      data['progressLabourLinkings'] =
          progressLabourLinkings!.map((v) => v.toJson()).toList();
    }
    if (progressContByPwr != null) {
      data['progressContByPwr'] =
          progressContByPwr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DebitContractor {
  String? contractorName;

  DebitContractor({this.contractorName});

  DebitContractor.fromJson(Map<String, dynamic> json) {
    contractorName = json['contractor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractor_name'] = contractorName;
    return data;
  }
}

class ProgressImagebyDaily {
  int? id;
  int? progressId;
  int? progressDailyId;
  String? fileName;
  String? createdAt;
  String? updatedAt;

  ProgressImagebyDaily(
      {this.id,
      this.progressId,
      this.progressDailyId,
      this.fileName,
      this.createdAt,
      this.updatedAt});

  ProgressImagebyDaily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    progressId = json['progress_id'];
    progressDailyId = json['progress_daily_id'];
    fileName = json['file_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['progress_id'] = progressId;
    data['progress_daily_id'] = progressDailyId;
    data['file_name'] = fileName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProgressLabourLinkings {
  int? progessLinkId;
  int? progressDailyId;
  int? progressId;
  int? contractorId;
  String? progressDate;
  int? contractorLabourLinkingId;
  String? time;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  ProgressLabourInfoByCll? progressLabourInfoByCll;
  ProgressContractorInfoByPc? progressContractorInfoByPc;

  ProgressLabourLinkings(
      {this.progessLinkId,
      this.progressDailyId,
      this.progressId,
      this.contractorId,
      this.progressDate,
      this.contractorLabourLinkingId,
      this.time,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.progressLabourInfoByCll,
      this.progressContractorInfoByPc});

  ProgressLabourLinkings.fromJson(Map<String, dynamic> json) {
    progessLinkId = json['progess_link_id'];
    progressDailyId = json['progress_daily_id'];
    progressId = json['progress_id'];
    contractorId = json['contractor_id'];
    progressDate = json['progress_date'];
    contractorLabourLinkingId = json['contractor_labour_linking_id'];
    time = json['time'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    progressLabourInfoByCll = json['progressLabourInfoByCll'] != null
        ? ProgressLabourInfoByCll.fromJson(json['progressLabourInfoByCll'])
        : null;
    progressContractorInfoByPc = json['progressContractorInfoByPc'] != null
        ? ProgressContractorInfoByPc.fromJson(
            json['progressContractorInfoByPc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['progess_link_id'] = progessLinkId;
    data['progress_daily_id'] = progressDailyId;
    data['progress_id'] = progressId;
    data['contractor_id'] = contractorId;
    data['progress_date'] = progressDate;
    data['contractor_labour_linking_id'] = contractorLabourLinkingId;
    data['time'] = time;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (progressLabourInfoByCll != null) {
      data['progressLabourInfoByCll'] = progressLabourInfoByCll!.toJson();
    }
    if (progressContractorInfoByPc != null) {
      data['progressContractorInfoByPc'] =
          progressContractorInfoByPc!.toJson();
    }
    return data;
  }
}

class ProgressLabourInfoByCll {
  int? id;
  int? clientId;
  int? projectId;
  int? clientContractorId;
  String? type;
  int? tradeId;
  int? workingHrs;
  String? name;
  int? rate;
  int? otRate;
  String? aadhar;
  String? createdAt;
  String? updatedAt;

  ProgressLabourInfoByCll(
      {this.id,
      this.clientId,
      this.projectId,
      this.clientContractorId,
      this.type,
      this.tradeId,
      this.workingHrs,
      this.name,
      this.rate,
      this.otRate,
      this.aadhar,
      this.createdAt,
      this.updatedAt});

  ProgressLabourInfoByCll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    clientContractorId = json['client_contractor_id'];
    type = json['type'];
    tradeId = json['trade_id'];
    workingHrs = json['working_hrs'];
    name = json['name'];
    rate = json['rate'];
    otRate = json['ot_rate'];
    aadhar = json['aadhar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['client_contractor_id'] = clientContractorId;
    data['type'] = type;
    data['trade_id'] = tradeId;
    data['working_hrs'] = workingHrs;
    data['name'] = name;
    data['rate'] = rate;
    data['ot_rate'] = otRate;
    data['aadhar'] = aadhar;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProgressContractorInfoByPc {
  String? contractorName;
  int? id;

  ProgressContractorInfoByPc({this.contractorName, this.id});

  ProgressContractorInfoByPc.fromJson(Map<String, dynamic> json) {
    contractorName = json['contractor_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractor_name'] = contractorName;
    data['id'] = id;
    return data;
  }
}

class ProgressContByPwr {
  int? id;
  int? progressId;
  int? progressDailyId;
  int? contractorId;
  int? pwrType;
  // ignore: prefer_typing_uninitialized_variables
  var labourType;
  int? labourCount;
  String? progressDate;
  String? createdAt;
  String? updatedAt;
  PwrContractorInfoByPc? pwrContractorInfoByPc;

  ProgressContByPwr(
      {this.id,
      this.progressId,
      this.progressDailyId,
      this.contractorId,
      this.pwrType,
      this.labourType,
      this.labourCount,
      this.progressDate,
      this.createdAt,
      this.updatedAt,
      this.pwrContractorInfoByPc});

  ProgressContByPwr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    progressId = json['progress_id'];
    progressDailyId = json['progress_daily_id'];
    contractorId = json['contractor_id'];
    pwrType = json['pwr_type'];
    labourType = json['labour_type'];
    labourCount = json['labour_count'];
    progressDate = json['progress_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pwrContractorInfoByPc = json['pwrContractorInfoByPc'] != null
        ? PwrContractorInfoByPc.fromJson(json['pwrContractorInfoByPc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['progress_id'] = progressId;
    data['progress_daily_id'] = progressDailyId;
    data['contractor_id'] = contractorId;
    data['pwr_type'] = pwrType;
    data['labour_type'] = labourType;
    data['labour_count'] = labourCount;
    data['progress_date'] = progressDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pwrContractorInfoByPc != null) {
      data['pwrContractorInfoByPc'] = pwrContractorInfoByPc!.toJson();
    }
    return data;
  }
}

class PwrContractorInfoByPc {
  int? id;
  int? clientId;
  int? projectId;
  int? clientContractorId;
  String? contractorName;
  String? startDate;
  String? endDate;
  String? workOrderNumber;
  String? scopeOfWork;
  String? contactNo;
  // ignore: prefer_typing_uninitialized_variables
  var attFile;
  int? grandTotal;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  PwrContractorInfoByPc(
      {this.id,
      this.clientId,
      this.projectId,
      this.clientContractorId,
      this.contractorName,
      this.startDate,
      this.endDate,
      this.workOrderNumber,
      this.scopeOfWork,
      this.contactNo,
      this.attFile,
      this.grandTotal,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  PwrContractorInfoByPc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    clientContractorId = json['client_contractor_id'];
    contractorName = json['contractor_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    workOrderNumber = json['work_order_number'];
    scopeOfWork = json['scope_of_work'];
    contactNo = json['contact_no'];
    attFile = json['att_file'];
    grandTotal = json['grand_total'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['client_contractor_id'] = clientContractorId;
    data['contractor_name'] = contractorName;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['work_order_number'] = workOrderNumber;
    data['scope_of_work'] = scopeOfWork;
    data['contact_no'] = contactNo;
    data['att_file'] = attFile;
    data['grand_total'] = grandTotal;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}