class ProgressActivityData {
  bool? success;
  List<ProjectActivityHead>? projectActivityHead;

  ProgressActivityData({this.success, this.projectActivityHead});

  ProgressActivityData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['projectActivityHead'] != null) {
      projectActivityHead = <ProjectActivityHead>[];
      json['projectActivityHead'].forEach((v) {
        projectActivityHead!.add(ProjectActivityHead.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (projectActivityHead != null) {
      data['projectActivityHead'] =
          projectActivityHead!.map((v) => v.toJson()).toList();
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