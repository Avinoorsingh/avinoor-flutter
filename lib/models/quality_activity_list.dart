class QualityActivityList {
  bool? success;
  List<ProjectActivityHead>? data;

  QualityActivityList({this.success, this.data});

  QualityActivityList.fromJson(var json) {
    data =  [];
    for(var data1 in json){
      data?.add(ProjectActivityHead.fromJson(data1));    
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] =
         this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectActivityHead {
  int? linkingActivityId;
  String? activity;

  ProjectActivityHead({this.linkingActivityId, this.activity});

  ProjectActivityHead.fromJson(Map<String, dynamic> json) {
    linkingActivityId = json['linking_activity_id'];
    activity = json['activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['linking_activity_id'] = linkingActivityId;
    data['activity'] = activity;
    return data;
  }
}