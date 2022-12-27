class SectionDetail {
  bool? success;
  List<SectionData>? data;

  SectionDetail({this.success, this.data});

  SectionDetail.fromJson(var json) {
    data =  [];
    for(var data1 in json){
      data?.add(SectionData.fromJson(data1));    
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

class SectionData {
  String? cmStatus;
  int? checklistSectionLinkingId;
  int? editId;
  int? cId;
  String? newCheckCode;
  String? sectionName;
  String? sectionQuestion;
  int? id;
  int? cSId;
  String? status;
  String? checkedStatus;
  int? lineCommentRequired;
  int? imageRequired;
  String? lineComment;
  String? image;
  int? debetContactor;
  int? debitAmount;
  String? dueDate;
  String? remarks;
  int? linkActivityId;

  SectionData(
      {this.cmStatus,
      this.checklistSectionLinkingId,
      this.editId,
      this.cId,
      this.newCheckCode,
      this.sectionName,
      this.sectionQuestion,
      this.id,
      this.cSId,
      this.status,
      this.checkedStatus,
      this.lineCommentRequired,
      this.imageRequired,
      this.lineComment,
      this.image,
      this.debetContactor,
      this.debitAmount,
      this.dueDate,
      this.remarks,
      this.linkActivityId});

  SectionData.fromJson(Map<String, dynamic> json) {
    cmStatus = json['cm_status'];
    checklistSectionLinkingId = json['checklist_section_linking_id'];
    editId = json['editId'];
    cId = json['c_id'];
    newCheckCode = json['new_check_code'];
    sectionName = json['section_name'];
    sectionQuestion = json['section_question'];
    id = json['id'];
    cSId = json['c_s_id'];
    status = json['status'];
    checkedStatus = json['checked_status'];
    lineCommentRequired = json['line_comment_required'];
    imageRequired = json['image_required'];
    lineComment = json['line_comment'];
    image = json['image'];
    debetContactor = json['debet_contactor'];
    debitAmount = json['debit_amount'];
    dueDate = json['due_date'];
    remarks = json['remarks'];
    linkActivityId = json['link_activity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cm_status'] = cmStatus;
    data['checklist_section_linking_id'] = checklistSectionLinkingId;
    data['editId'] = editId;
    data['c_id'] = cId;
    data['new_check_code'] = newCheckCode;
    data['section_name'] = sectionName;
    data['section_question'] = sectionQuestion;
    data['id'] = id;
    data['c_s_id'] = cSId;
    data['status'] = status;
    data['checked_status'] = checkedStatus;
    data['line_comment_required'] = lineCommentRequired;
    data['image_required'] = imageRequired;
    data['line_comment'] = lineComment;
    data['image'] = image;
    data['debet_contactor'] = debetContactor;
    data['debit_amount'] = debitAmount;
    data['due_date'] = dueDate;
    data['remarks'] = remarks;
    data['link_activity_id'] = linkActivityId;
    return data;
  }
}
