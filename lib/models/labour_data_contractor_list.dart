class LabourDataContractorList {
  bool? success;
  List<LabourDataContractorListData>? data;

  LabourDataContractorList({this.success, this.data});

  LabourDataContractorList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <LabourDataContractorListData>[];
      json['data'].forEach((v) {
        data!.add(LabourDataContractorListData.fromJson(v));
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

class LabourDataContractorListData {
  int? pid;
  String? contractorName;
  String? contactNo;
  String? type;

  LabourDataContractorListData({this.pid, this.contractorName, this.contactNo, this.type});

  LabourDataContractorListData.fromJson(Map<String, dynamic> json) {
    pid = json['Pid'];
    contractorName = json['contractor_name'];
    contactNo = json['contact_no'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Pid'] = pid;
    data['contractor_name'] = contractorName;
    data['contact_no'] = contactNo;
    data['type'] = type;
    return data;
  }
}