class ProgressContractor {
  bool? success;
  List<ProgressDataContractorListData>? data;

  ProgressContractor({this.success, this.data});

  ProgressContractor.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProgressDataContractorListData>[];
      json['data'].forEach((v) {
        data!.add(ProgressDataContractorListData.fromJson(v));
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

class ProgressDataContractorListData {
  int? pid;
  String? contractorName;
  String? contactNo;
  String? type;

  ProgressDataContractorListData({this.pid, this.contractorName, this.contactNo, this.type});

  ProgressDataContractorListData.fromJson(Map<String, dynamic> json) {
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