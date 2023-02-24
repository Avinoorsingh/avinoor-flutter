class SnagCount {
  String? status;
  int? snagCount;
  int? deSnagCount;

  SnagCount({this.status, this.snagCount, this.deSnagCount});

  SnagCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    snagCount = json['snagCount'];
    deSnagCount = json['deSnagCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['snagCount'] = snagCount;
    data['deSnagCount'] = deSnagCount;
    return data;
  }
}