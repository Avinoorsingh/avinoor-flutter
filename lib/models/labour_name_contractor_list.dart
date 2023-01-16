class LabourNameContractorList {
  bool? success;
  List<LabourNameContractorListData>? data;

  LabourNameContractorList({this.success, this.data});

  LabourNameContractorList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <LabourNameContractorListData>[];
      json['data'].forEach((v) {
        data!.add(LabourNameContractorListData.fromJson(v));
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

class LabourNameContractorListData {
  int? id;
  int? tradeId;
  int? clientContractorId;
  String? type;
  int? workingHrs;
  String? name;
  int? rate;
  int? otRate;
  String? aadhar;
  String? trade;

  LabourNameContractorListData(
      {this.id,
      this.tradeId,
      this.clientContractorId,
      this.type,
      this.workingHrs,
      this.name,
      this.rate,
      this.otRate,
      this.aadhar,
      this.trade});

  LabourNameContractorListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tradeId = json['trade_id'];
    clientContractorId = json['client_contractor_id'];
    type = json['type'];
    workingHrs = json['working_hrs'];
    name = json['name'];
    rate = json['rate'];
    otRate = json['ot_rate'];
    aadhar = json['aadhar'];
    trade = json['trade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trade_id'] = tradeId;
    data['client_contractor_id'] = clientContractorId;
    data['type'] = type;
    data['working_hrs'] = workingHrs;
    data['name'] = name;
    data['rate'] = rate;
    data['ot_rate'] = otRate;
    data['aadhar'] = aadhar;
    data['trade'] = trade;
    return data;
  }
}