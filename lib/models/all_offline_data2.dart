class AllOfflineData {
  List<LocationOfflineData>? locationOfflineData;
  List? ongoingProgress;
  List<MasterImageOfSnag>? masterImageOfSnag;
  List<LabourSupply>? labourSupply;


  AllOfflineData(
      {this.locationOfflineData,
      this.ongoingProgress,
      this.masterImageOfSnag,
      this.labourSupply});

  AllOfflineData.fromJson(Map<String, dynamic> json) {
    if (json['locationOfflineData'] != null) {
      locationOfflineData = <LocationOfflineData>[];
      json['locationOfflineData'].forEach((v) {
        locationOfflineData!.add(LocationOfflineData.fromJson(v));
      });
    }
    if (json['masterImageOfSnag'] != null) {
      masterImageOfSnag = <MasterImageOfSnag>[];
      json['masterImageOfSnag'].forEach((v) {
        masterImageOfSnag!.add(MasterImageOfSnag.fromJson(v));
      });
    }
    if (json['labourSupply'] != null) {
      labourSupply = <LabourSupply>[];
      json['labourSupply'].forEach((v) {
        labourSupply!.add(LabourSupply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (locationOfflineData != null) {
      data['locationOfflineData'] =
          locationOfflineData!.map((v) => v.toJson()).toList();
    }
    if (ongoingProgress != null) {
      data['ongoingProgress'] =
          ongoingProgress!.map((v) => v.toJson()).toList();
    }
    if (masterImageOfSnag != null) {
      data['masterImageOfSnag'] =
          masterImageOfSnag!.map((v) => v.toJson()).toList();
    }
    if (labourSupply != null) {
      data['labourSupply'] = labourSupply!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationOfflineData {
  int? locationId;
  String? locationName;
  List<SubLocationInfo>? subLocationInfo;
  int? countLoc;

  LocationOfflineData(
      {this.locationId,
      this.locationName,
      this.subLocationInfo,
      this.countLoc});

  LocationOfflineData.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    locationName = json['location_name'];
    if (json['subLocationInfo'] != null) {
      subLocationInfo = <SubLocationInfo>[];
      json['subLocationInfo'].forEach((v) {
        subLocationInfo!.add(SubLocationInfo.fromJson(v));
      });
    }
    countLoc = json['count_loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['location_name'] = locationName;
    if (subLocationInfo != null) {
      data['subLocationInfo'] =
          subLocationInfo!.map((v) => v.toJson()).toList();
    }
    data['count_loc'] = countLoc;
    return data;
  }
}

class SubLocationInfo {
  int? subLocId;
  String? subLocationName;
  int? locationId;
  ViewPointMaster? viewPointMaster;
  List<SubSubLocationInfo>? subSubLocationInfo;
  int? countSubLoc;

  SubLocationInfo(
      {this.subLocId,
      this.subLocationName,
      this.locationId,
      this.viewPointMaster,
      this.subSubLocationInfo,
      this.countSubLoc});

  SubLocationInfo.fromJson(Map<String, dynamic> json) {
    subLocId = json['sub_loc_id'];
    subLocationName = json['sub_location_name'];
    locationId = json['location_id'];
    viewPointMaster = json['viewPointMaster'] != null
        ? ViewPointMaster.fromJson(json['viewPointMaster'])
        : null;
    if (json['subSubLocationInfo'] != null) {
      subSubLocationInfo = <SubSubLocationInfo>[];
      json['subSubLocationInfo'].forEach((v) {
        subSubLocationInfo!.add(SubSubLocationInfo.fromJson(v));
      });
    }
    countSubLoc = json['count_sub_loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_loc_id'] = subLocId;
    data['sub_location_name'] = subLocationName;
    data['location_id'] = locationId;
    if (viewPointMaster != null) {
      data['viewPointMaster'] = viewPointMaster!.toJson();
    }
    if (subSubLocationInfo != null) {
      data['subSubLocationInfo'] =
          subSubLocationInfo!.map((v) => v.toJson()).toList();
    }
    data['count_sub_loc'] = countSubLoc;
    return data;
  }
}

class ViewPointMaster {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? locationId;
  int? subLocId;
  String? fileName;

  ViewPointMaster({
      this.id,
      this.createdAt,
      this.updatedAt,
      this.locationId,
      this.subLocId,
      this.fileName
      });

  ViewPointMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['file_name'] = fileName;
    return data;
  }
}

class SubSubLocationInfo {
  String? subSubLocationName;
  int? subLocationId;
  int? locationId;
  int? subLocId;
  List<ViewPointNumberlist>? viewPointNumberlist;
  List<SubSubLocationActivity>? subSubLocationActivity;
  int? countSubSubLoc;

  SubSubLocationInfo(
      {
      this.subSubLocationName,
      this.subLocationId,
      this.locationId,
      this.subLocId,
      this.viewPointNumberlist,
      this.subSubLocationActivity,
      this.countSubSubLoc});

  SubSubLocationInfo.fromJson(Map<String, dynamic> json) {
    subSubLocationName = json['sub_sub_location_name'];
    subLocationId = json['sub_location_id'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    if (json['viewPointNumberlist'] != null) {
      viewPointNumberlist = <ViewPointNumberlist>[];
      json['viewPointNumberlist'].forEach((v) {
        viewPointNumberlist!.add(ViewPointNumberlist.fromJson(v));
      });
    }
    if (json['subSubLocationActivity'] != null) {
      subSubLocationActivity = <SubSubLocationActivity>[];
      json['subSubLocationActivity'].forEach((v) {
        subSubLocationActivity!.add(SubSubLocationActivity.fromJson(v));
      });
    }
    countSubSubLoc = json['count_sub_sub_loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_sub_location_name'] = subSubLocationName;
    data['sub_location_id'] = subLocationId;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    if (viewPointNumberlist != null) {
      data['viewPointNumberlist'] =
          viewPointNumberlist!.map((v) => v.toJson()).toList();
    }
    if (subSubLocationActivity != null) {
      data['subSubLocationActivity'] =
          subSubLocationActivity!.map((v) => v.toJson()).toList();
    }
    data['count_sub_sub_loc'] = countSubSubLoc;
    return data;
  }
}

class ViewPointNumberlist {
  int? id;
  int? viewpointSubSubLocId;
  int? subSubLocationId;
  String? viewpoint;
  int? viewpointMasterId;
  String? createdAt;
  String? updatedAt;

  ViewPointNumberlist(
      {
      this.id,
      this.viewpointSubSubLocId,
      this.subSubLocationId,
      this.viewpoint,
      this.viewpointMasterId,
      this.createdAt,
      this.updatedAt});

  ViewPointNumberlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    viewpointSubSubLocId = json['viewpoint_sub_sub_loc_id'];
    subSubLocationId = json['sub_sub_location_id'];
    viewpoint = json['viewpoint'];
    viewpointMasterId = json['viewpoint_master_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['viewpoint_sub_sub_loc_id'] = viewpointSubSubLocId;
    data['sub_sub_location_id'] = subSubLocationId;
    data['viewpoint'] = viewpoint;
    data['viewpoint_master_id'] = viewpointMasterId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SubSubLocationActivity {
  int? linkingActivityId;
  String? activity;
  int? quantity;
  // ignore: prefer_typing_uninitialized_variables
  var productivity;
  String? activityHead;
  String? contractorName;
  String? uomName;
  int? contId;
  ProgressAdd? progressAdd;

  SubSubLocationActivity(
      {this.linkingActivityId,
      this.activity,
      this.quantity,
      this.productivity,
      this.activityHead,
      this.contractorName,
      this.uomName,
      this.contId,
      this.progressAdd});

  SubSubLocationActivity.fromJson(Map<String, dynamic> json) {
    linkingActivityId = json['linking_activity_id'];
    activity = json['activity'];
    quantity = json['quantity'];
    productivity = json['productivity'];
    activityHead = json['activity_head'];
    contractorName = json['contractor_name'];
    uomName = json['uom_name'];
    contId = json['cont_id'];
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
    data['activity_head'] = activityHead;
    data['contractor_name'] = contractorName;
    data['uom_name'] = uomName;
    data['cont_id'] = contId;
    if (progressAdd != null) {
      data['progressAdd'] = progressAdd!.toJson();
    }
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
  int? cumulativeQuantity;
  int? achivedQuantity;
  int? totalQuantity;
  String? progressDate;
  int? progressPercentage;
  int? debetContactor;
  int? progType;
  String? remarks;
  int? draftStatus;
  String? createdAt;
  String? updatedAt;
  ProgressImagebyDaily? progressImagebyDaily;
  DebitContractor? debitContractor;
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
      this.progressImagebyDaily,
      this.debitContractor,
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
    progressImagebyDaily = json['progressImagebyDaily'] != null
        ? ProgressImagebyDaily.fromJson(json['progressImagebyDaily'])
        : null;
    debitContractor = json['debitContractor'] != null
        ? DebitContractor.fromJson(json['debitContractor'])
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
    if (progressImagebyDaily != null) {
      data['progressImagebyDaily'] = progressImagebyDaily!.toJson();
    }
    if (debitContractor != null) {
      data['debitContractor'] = debitContractor!.toJson();
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
  ProgressContractorInfoByPc? progressContractorInfoByPc;
  ProgressLabourInfoByCll? progressLabourInfoByCll;

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
      this.progressContractorInfoByPc,
      this.progressLabourInfoByCll});

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
    progressContractorInfoByPc = json['progressContractorInfoByPc'] != null
        ? ProgressContractorInfoByPc.fromJson(
            json['progressContractorInfoByPc'])
        : null;
    progressLabourInfoByCll = json['progressLabourInfoByCll'] != null
        ? ProgressLabourInfoByCll.fromJson(json['progressLabourInfoByCll'])
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
    if (progressContractorInfoByPc != null) {
      data['progressContractorInfoByPc'] =
          progressContractorInfoByPc!.toJson();
    }
    if (progressLabourInfoByCll != null) {
      data['progressLabourInfoByCll'] = progressLabourInfoByCll!.toJson();
    }
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
      {
      this.id,
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

class MasterImageOfSnag {
  int? locationId;
  int? subLocId;
  int? subSubLocationId;
  int? viewpointNameId;
  String? fileName;
  int? fileNameId;
  String? viewpoint;
  String? masterFile;

  MasterImageOfSnag(
      {this.locationId,
      this.subLocId,
      this.subSubLocationId,
      this.viewpointNameId,
      this.fileName,
      this.fileNameId,
      this.viewpoint,
      this.masterFile});

  MasterImageOfSnag.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocationId = json['sub_sub_location_id'];
    viewpointNameId = json['viewpoint_name_id'];
    fileName = json['file_name'];
    fileNameId = json['file_name_id'];
    viewpoint = json['viewpoint'];
    masterFile = json['master_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_location_id'] = subSubLocationId;
    data['viewpoint_name_id'] = viewpointNameId;
    data['file_name'] = fileName;
    data['file_name_id'] = fileNameId;
    data['viewpoint'] = viewpoint;
    data['master_file'] = masterFile;
    return data;
  }
}

class LabourSupply {
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
  List<ContractorLabourLinking>? contractorLabourLinking;

  LabourSupply(
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
      this.updatedAt,
      this.contractorLabourLinking});

  LabourSupply.fromJson(Map<String, dynamic> json) {
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
    if (json['contractorLabourLinking'] != null) {
      contractorLabourLinking = <ContractorLabourLinking>[];
      json['contractorLabourLinking'].forEach((v) {
        contractorLabourLinking!.add(ContractorLabourLinking.fromJson(v));
      });
    }
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
    if (contractorLabourLinking != null) {
      data['contractorLabourLinking'] =
          contractorLabourLinking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContractorLabourLinking {
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

  ContractorLabourLinking(
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

  ContractorLabourLinking.fromJson(Map<String, dynamic> json) {
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