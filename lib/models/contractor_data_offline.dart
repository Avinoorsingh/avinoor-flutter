class ContractorDataOffline {
  List<ContractorData>? data;
  List<WorkOrderLocationMaster>? workOrderLocationMaster;

  ContractorDataOffline({this.data, this.workOrderLocationMaster});

  ContractorDataOffline.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ContractorData>[];
      json['data'].forEach((v) {
        data!.add(ContractorData.fromJson(v));
      });
    }
    if (json['workOrderLocationMaster'] != null) {
      workOrderLocationMaster = <WorkOrderLocationMaster>[];
      json['workOrderLocationMaster'].forEach((v) {
        workOrderLocationMaster!.add(WorkOrderLocationMaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (workOrderLocationMaster != null) {
      data['workOrderLocationMaster'] =
          workOrderLocationMaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContractorData {
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
  List<SupplyProjectContractorBoqDetails>? supplyProjectContractorBoqDetails;

  ContractorData(
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
      this.contractorLabourLinking,
      this.supplyProjectContractorBoqDetails});

  ContractorData.fromJson(Map<String, dynamic> json) {
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
    if (json['SupplyProjectContractorBoqDetails'] != null) {
      supplyProjectContractorBoqDetails = <SupplyProjectContractorBoqDetails>[];
      json['SupplyProjectContractorBoqDetails'].forEach((v) {
        supplyProjectContractorBoqDetails!
            .add(SupplyProjectContractorBoqDetails.fromJson(v));
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
    if (supplyProjectContractorBoqDetails != null) {
      data['SupplyProjectContractorBoqDetails'] = supplyProjectContractorBoqDetails!
          .map((v) => v.toJson())
          .toList();
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

class SupplyProjectContractorBoqDetails {
  int? id;
  int? conLinkId;
  String? activity;
  int? clientContractorId;
  String? type;
  int? typeOfLabour;
  int? tradeId;
  int? workingHrs;
  int? otRate;
  String? lineItems;
  int? uomId;
  int? rate;
  int? quantityId;
  int? quantity;
  String? activityName;
  String? activityHead;
  int? conversionFactor;
  int? amount;
  // ignore: prefer_typing_uninitialized_variables
  var grandTotal;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  SupplyProjectContractorBoqDetails(
      {
      this.id,
      this.conLinkId,
      this.activity,
      this.clientContractorId,
      this.type,
      this.typeOfLabour,
      this.tradeId,
      this.workingHrs,
      this.otRate,
      this.lineItems,
      this.uomId,
      this.rate,
      this.quantityId,
      this.quantity,
      this.activityName,
      this.activityHead,
      this.conversionFactor,
      this.amount,
      this.grandTotal,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  SupplyProjectContractorBoqDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conLinkId = json['con_link_id'];
    activity = json['activity'];
    clientContractorId = json['client_contractor_id'];
    type = json['type'];
    typeOfLabour = json['type_of_labour'];
    tradeId = json['trade_id'];
    workingHrs = json['working_hrs'];
    otRate = json['ot_rate'];
    lineItems = json['line_items'];
    uomId = json['uom_id'];
    rate = json['rate'];
    quantityId = json['quantity_id'];
    quantity = json['quantity'];
    activityName = json['activity_name'];
    activityHead = json['activity_head'];
    conversionFactor = json['conversion_factor'];
    amount = json['amount'];
    grandTotal = json['grand_total'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['con_link_id'] = conLinkId;
    data['activity'] = activity;
    data['client_contractor_id'] = clientContractorId;
    data['type'] = type;
    data['type_of_labour'] = typeOfLabour;
    data['trade_id'] = tradeId;
    data['working_hrs'] = workingHrs;
    data['ot_rate'] = otRate;
    data['line_items'] = lineItems;
    data['uom_id'] = uomId;
    data['rate'] = rate;
    data['quantity_id'] = quantityId;
    data['quantity'] = quantity;
    data['activity_name'] = activityName;
    data['activity_head'] = activityHead;
    data['conversion_factor'] = conversionFactor;
    data['amount'] = amount;
    data['grand_total'] = grandTotal;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class WorkOrderLocationMaster {
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

  WorkOrderLocationMaster(
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
      this.updatedAt});

  WorkOrderLocationMaster.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}