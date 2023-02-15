// ignore_for_file: file_names

class ContractorName {
  bool? success;
  List<Data>? data;

  ContractorName({this.success, this.data});

  ContractorName.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? contractorName;
  int? id;

  Data({this.contractorName, this.id});

  Data.fromJson(Map<String, dynamic> json) {
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
