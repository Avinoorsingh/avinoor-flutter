import 'package:flutter/foundation.dart';

class SnagData {
  String? status;
  List<FetchSnagData>? data;

  SnagData({this.status, this.data});

  SnagData.fromJson(var json) {
      data =  [];
    for(var data1 in json){
      try {
         data?.add(FetchSnagData.fromJson(data1));   
      } catch (e) {
        if (kDebugMode) {
          print("Errorrrrrrr!!!!");
          print(e);
        }
      } 
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FetchSnagData {
  int? id;
  int? clientId;
  int? projectId;
  int? categoryId;
  int? locationId;
  int? subLocId;
  int? subSubLocId;
  int? activityHeadId;
  int? activityId;
  int? contractorId;
  String? remark;
  String? deSnagRemark;
  String? closeSnagRemark;
  String? debitNote;
  int? debitAmount;
  String? dueDate;
  int? assignedTo;
  int? debetContractorId;
  String? markupFile;
  String? snagPriority;
  String? snagStatus;
  int? rejectCount;
  int? createdby2;
  String? rm;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  Location? location;
  SubLocation? subLocation;
  SubSubLocation? subSubLocation;
  ProjectActivityHead? projectActivityHead;
  ProjectActivity? projectActivity;
  ContractorInfo? contractorInfo;
  ProjcontractorInfo? projcontractorInfo;
  ProjcontractorInfo? debetcontractorInfo;
  Category? category;
  List<SnagViewpoint>? snagViewpoint;
  // List? snagViewpoint;
  Employee? employee;
  CreatedBy? createdBy1;

  FetchSnagData(
      {this.id,
      this.clientId,
      this.projectId,
      this.categoryId,
      this.locationId,
      this.subLocId,
      this.subSubLocId,
      this.activityHeadId,
      this.activityId,
      this.contractorId,
      this.remark,
      this.deSnagRemark,
      this.closeSnagRemark,
      this.debitNote,
      this.debitAmount,
      this.dueDate,
      this.assignedTo,
      this.debetContractorId,
      this.markupFile,
      this.snagPriority,
      this.snagStatus,
      this.rejectCount,
      this.createdby2,
      this.rm,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.location,
      this.subLocation,
      this.subSubLocation,
      this.projectActivityHead,
      this.projectActivity,
      this.contractorInfo,
      this.projcontractorInfo,
      this.debetcontractorInfo,
      this.category,
      this.snagViewpoint,
      this.employee,
      this.createdBy1});

  FetchSnagData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    categoryId = json['category_id'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocId = json['sub_sub_loc_id'];
    activityHeadId = json['activity_head_id'];
    activityId = json['activity_id'];
    contractorId = json['contractor_id'];
    remark = json['remark'];
    deSnagRemark = json['de_snag_remark'];
    closeSnagRemark = json['close_snag_remark'];
    debitNote = json['debit_note'];
    debitAmount = json['debit_amount'];
    dueDate = json['due_date'];
    assignedTo = json['assigned_to'];
    debetContractorId = json['debet_contractor_id'];
    markupFile = json['markup_file'];
    snagPriority = json['snag_priority'];
    snagStatus = json['snag_status'];
    rejectCount = json['reject_count'];
    createdby2 = json['created_by'];
    rm = json['rm'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    subLocation = json['subLocation'] != null
        ? SubLocation.fromJson(json['subLocation'])
        : null;
    subSubLocation = json['subSubLocation'] != null
        ? SubSubLocation.fromJson(json['subSubLocation'])
        : null;
    projectActivityHead = json['projectActivityHead'] != null
        ? ProjectActivityHead.fromJson(json['projectActivityHead'])
        : null;
    projectActivity = json['projectActivity'] != null
        ? ProjectActivity.fromJson(json['projectActivity'])
        : null;
    contractorInfo = json['contractorInfo'] != null
        ? ContractorInfo.fromJson(json['contractorInfo'])
        : null;
    projcontractorInfo = json['ProjcontractorInfo'] != null
        ? ProjcontractorInfo.fromJson(json['ProjcontractorInfo'])
        : null;
    debetcontractorInfo = json['debetcontractorInfo'] != null
        ? ProjcontractorInfo.fromJson(json['debetcontractorInfo'])
        : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    if (json['snagViewpoint'] != null) {
      snagViewpoint = <SnagViewpoint>[];
      json['snagViewpoint'].forEach((v) {
        snagViewpoint!.add(SnagViewpoint.fromJson(v));
      });
    }
    // if (json['snagViewpoint'] != null) {
    //   snagViewpoint = <Null>[];
    //   json['snagViewpoint'].forEach((v) {
    //     snagViewpoint!.add(SnagV.fromJson(v));
    //   });
    // }
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    createdBy1 = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['category_id'] = categoryId;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_loc_id'] = subSubLocId;
    data['activity_head_id'] = activityHeadId;
    data['activity_id'] = activityId;
    data['contractor_id'] = contractorId;
    data['remark'] = remark;
    data['de_snag_remark'] = deSnagRemark;
    data['close_snag_remark'] = closeSnagRemark;
    data['debit_note'] = debitNote;
    data['debit_amount'] = debitAmount;
    data['due_date'] = dueDate;
    data['assigned_to'] = assignedTo;
    data['debet_contractor_id'] = debetContractorId;
    data['markup_file'] = markupFile;
    data['snag_priority'] = snagPriority;
    data['snag_status'] = snagStatus;
    data['reject_count'] = rejectCount;
    data['created_by'] = createdby2;
    data['rm'] = rm;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (subLocation != null) {
      data['subLocation'] = subLocation!.toJson();
    }
    if (subSubLocation != null) {
      data['subSubLocation'] = subSubLocation!.toJson();
    }
    if (projectActivityHead != null) {
      data['projectActivityHead'] = projectActivityHead!.toJson();
    }
    if (projectActivity != null) {
      data['projectActivity'] = projectActivity!.toJson();
    }
    if (contractorInfo != null) {
      data['contractorInfo'] = contractorInfo!.toJson();
    }
    if (projcontractorInfo != null) {
      data['ProjcontractorInfo'] = projcontractorInfo!.toJson();
    }
    if (debetcontractorInfo != null) {
      data['debetcontractorInfo'] = debetcontractorInfo!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
     if (snagViewpoint != null) {
      data['snagViewpoint'] =
          snagViewpoint!.map((v) => v.toJson()).toList();
    }
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (createdby2 != null) {
      data['createdby2'] = createdBy1!.toJson();
    }
    return data;
  }
}

class Location {
  int? locationId;
  int? projectId;
  int? clientId;
  String? locationName;
  String? createdAt;
 String? updatedAt;
 String? createdby2;
 String? updatedBy;

  Location(
      {this.locationId,
      this.projectId,
      this.clientId,
      this.locationName,
      this.createdAt,
      this.updatedAt,
      this.createdby2,
      this.updatedBy});

  Location.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    locationName = json['location_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdby2 = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['project_id'] = projectId;
    data['client_id'] = clientId;
    data['location_name'] = locationName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    return data;
  }
}

class SubLocation {
  int? subLocId;
  int? locationId;
  int? projectId;
  int? clientId;
  int? orderNo;
  String? subLocationName;
  int? createdby2;
 String? updatedBy;
  String? createdAt;
  String? updatedAt;

  SubLocation(
      {this.subLocId,
      this.locationId,
      this.projectId,
      this.clientId,
      this.orderNo,
      this.subLocationName,
      this.createdby2,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  SubLocation.fromJson(Map<String, dynamic> json) {
    subLocId = json['sub_loc_id'];
    locationId = json['location_id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    orderNo = json['order_no'];
    subLocationName = json['sub_location_name'];
    createdby2 = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_loc_id'] = subLocId;
    data['location_id'] = locationId;
    data['project_id'] = projectId;
    data['client_id'] = clientId;
    data['order_no'] = orderNo;
    data['sub_location_name'] = subLocationName;
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SubSubLocation {
  int? subLocationId;
  int? clientId;
  int? projectId;
  int? locationId;
  int? subLocId;
  String? subSubLocationName;
  int? createdby2;
 String? updatedBy;
  String? createdAt;
 String? updatedAt;

  SubSubLocation(
      {this.subLocationId,
      this.clientId,
      this.projectId,
      this.locationId,
      this.subLocId,
      this.subSubLocationName,
      this.createdby2,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  SubSubLocation.fromJson(Map<String, dynamic> json) {
    subLocationId = json['sub_location_id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocationName = json['sub_sub_location_name'];
    createdby2 = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_location_id'] = subLocationId;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_location_name'] = subSubLocationName;
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProjectActivityHead {
  int? activityId;
  int? clientId;
  int? projectId;
  int? activityTypeId;
  String? activityHead;
  int? activityHeadOrder;
 String? import;
 String? description;
  int? createdby2;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  ProjectActivityHead(
      {this.activityId,
      this.clientId,
      this.projectId,
      this.activityTypeId,
      this.activityHead,
      this.activityHeadOrder,
      this.import,
      this.description,
      this.createdby2,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  ProjectActivityHead.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    activityTypeId = json['activity_type_id'];
    activityHead = json['activity_head'];
    activityHeadOrder = json['activity_head_order'];
    import = json['import'];
    description = json['description'];
    createdby2 = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_id'] = activityId;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['activity_type_id'] = activityTypeId;
    data['activity_head'] = activityHead;
    data['activity_head_order'] = activityHeadOrder;
    data['import'] = import;
    data['description'] = description;
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProjectActivity {
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
 String? import;
 String? createdby2;
 String? updatedBy;
  String? createdAt;
  String? updatedAt;

  ProjectActivity(
      {this.linkingActivityId,
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
      this.createdby2,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  ProjectActivity.fromJson(Map<String, dynamic> json) {
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
    createdby2 = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ContractorInfo {
  int? id;
  int? clientId;
  String? vendorCode;
  String? vendorType;
  String? nameOfCompany;
  String? yearOfRegestration;
  String? regesteredAddress;
  String? email;
  String? website;
  String? ownerName;
  String? owner;
  String? contactPerson;
  int? contactNo;
  String? panNo;
  String? gstNo;
  int? country;
  String? state;
  String? pf;
  String? bankName;
  String? branch;
  String? accountNo;
  String? accountType;
  String? ifscCode;
  String? micrCode;
  String? workAttribute;
  String? createdby2;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  ContractorInfo(
      {this.id,
      this.clientId,
      this.vendorCode,
      this.vendorType,
      this.nameOfCompany,
      this.yearOfRegestration,
      this.regesteredAddress,
      this.email,
      this.website,
      this.ownerName,
      this.owner,
      this.contactPerson,
      this.contactNo,
      this.panNo,
      this.gstNo,
      this.country,
      this.state,
      this.pf,
      this.bankName,
      this.branch,
      this.accountNo,
      this.accountType,
      this.ifscCode,
      this.micrCode,
      this.workAttribute,
      this.createdby2,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  ContractorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    vendorCode = json['vendor_code'];
    vendorType = json['vendor_type'];
    nameOfCompany = json['name_of_company'];
    yearOfRegestration = json['year_of_regestration'];
    regesteredAddress = json['regestered_address'];
    email = json['email'];
    website = json['website'];
    if(json['owner_name']!=null){
    ownerName = json['owner_name']??"owner";
    }
    owner = json['owner'];
    contactPerson = json['contact_person'];
    contactNo = json['contact_no'];
    panNo = json['pan_no'];
    gstNo = json['gst_no'];
    country = json['country'];
    state = json['state'];
    pf = json['pf'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    accountType = json['account_type'];
    ifscCode = json['ifsc_code'];
    micrCode = json['micr_code'];
    workAttribute = json['work_attribute'];
    createdby2 = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['vendor_code'] = vendorCode;
    data['vendor_type'] = vendorType;
    data['name_of_company'] = nameOfCompany;
    data['year_of_regestration'] = yearOfRegestration;
    data['regestered_address'] = regesteredAddress;
    data['email'] = email;
    data['website'] = website;
    data['owner_name'] = ownerName??"";
    data['owner'] = owner;
    data['contact_person'] = contactPerson;
    data['contact_no'] = contactNo;
    data['pan_no'] = panNo;
    data['gst_no'] = gstNo;
    data['country'] = country;
    data['state'] = state;
    data['pf'] = pf;
    data['bank_name'] = bankName;
    data['branch'] = branch;
    data['account_no'] = accountNo;
    data['account_type'] = accountType;
    data['ifsc_code'] = ifscCode;
    data['micr_code'] = micrCode;
    data['work_attribute'] = workAttribute;
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProjcontractorInfo {
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
  var attFile;
  int? grandTotal;
  String? createdby2;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  ProjcontractorInfo(
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
      this.createdby2,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  ProjcontractorInfo.fromJson(Map<String, dynamic> json) {
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
    createdby2 = json['created_by'];
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
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Category {
  int? id;
  int? clientId;
  int? projectId;
  String? name;
  String? description;
  String? createdAt;
 String? updatedAt;
  int? createdby2;
 String? updatedBy;

  Category(
      {this.id,
      this.clientId,
      this.projectId,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdby2,
      this.updatedBy});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdby2 = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdby2;
    data['updated_by'] = updatedBy;
    return data;
  }
}

class Employee {
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

  Employee(
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

  Employee.fromJson(Map<String, dynamic> json) {
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

class CreatedBy {
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

  CreatedBy(
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

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    userId = json['user_id'];
    password = json['password'];
    name = json['name']??"unavailable";
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

class SnagViewpoint {
  int? id;
  int? snagsMasterId;
  int? viewpointId;
  String? viewpointFileName;
  String? desnagsFileName;
  String? deSnagDate;
  String? createdAt;
  String? updatedAt;

  SnagViewpoint(
      {this.id,
      this.snagsMasterId,
      this.viewpointId,
      this.viewpointFileName,
      this.desnagsFileName,
      this.deSnagDate,
      this.createdAt,
      this.updatedAt});

  SnagViewpoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    snagsMasterId = json['snags_master_id'];
    viewpointId = json['viewpoint_id'];
    viewpointFileName = json['viewpoint_file_name'];
    desnagsFileName = json['desnags_file_name'];
    deSnagDate = json['de_snag_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['snags_master_id'] = snagsMasterId;
    data['viewpoint_id'] = viewpointId;
    data['viewpoint_file_name'] = viewpointFileName;
    data['desnags_file_name'] = desnagsFileName;
    data['de_snag_date'] = deSnagDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}