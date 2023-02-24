class ProgressCount1 {
  List<ProgressCount>? progressCount;

  ProgressCount1({this.progressCount});

  ProgressCount1.fromJson(Map<String, dynamic> json) {
    if (json['progressCount'] != null) {
      progressCount = <ProgressCount>[];
      json['progressCount'].forEach((v) {
        progressCount!.add(ProgressCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.progressCount != null) {
      data['progressCount'] =
          this.progressCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProgressCount {
  int? progressCount;

  ProgressCount({this.progressCount});

  ProgressCount.fromJson(Map<String, dynamic> json) {
    progressCount = json['progressCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['progressCount'] = this.progressCount;
    return data;
  }
}