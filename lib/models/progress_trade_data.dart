class ProgressTrade {
  bool? success;
  List<ProgressTradeData>? data;

  ProgressTrade({this.success, this.data});

  ProgressTrade.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProgressTradeData>[];
      json['data'].forEach((v) {
        data!.add(ProgressTradeData.fromJson(v));
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

class ProgressTradeData {
  int? id;
  String? trade;
  int? status;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  ProgressTradeData(
      {this.id,
      this.trade,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  ProgressTradeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trade = json['trade'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trade'] = trade;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}