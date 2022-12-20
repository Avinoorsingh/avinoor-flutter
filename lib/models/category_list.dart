class CategoryList {
  bool? success;
  List<Data>? data;

  CategoryList({this.success, this.data});

  CategoryList.fromJson(var json) {
     data =  [];
    for(var data1 in json){
      data?.add(Data.fromJson(data1));    
      }
    // print(json['data']);
    // success = json['success'];
    // if (json['data'] != null) {
    //   data =  [];
    //   json['data'].forEach((v) {
    //     data?.add(Data.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? clientId;
  int? projectId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;

  Data(
      {this.id,
      this.clientId,
      this.projectId,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    return data;
  }
}
