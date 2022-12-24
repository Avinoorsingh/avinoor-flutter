class Checklist {
	bool? success;
	List<New>? new1;
	List<Open>? open;
	List<Closed>? closed;

	Checklist({this.success, this.new1, this.open, this.closed});

	Checklist.fromJson(var json) {
		// success = json['success'];
    new1 =  [];
    for(var data1 in json){
      new1?.add(New.fromJson(data1));    
      }
    // open=[];
		// if (json['Open'] != null) {
		//  for(var data1 in json){
    //   open?.add(Open.fromJson(data1));    
    //   }
		// }
		// closed=[];
		// if (json['Closed'] != null) {
		//  for(var data1 in json){
    //   closed?.add(Closed.fromJson(data1));    
    //   }
		// }
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['success'] = success;
		if (new1 != null) {
      data['New'] = new1!.map((v) => v.toJson()).toList();
    }
		if (open != null) {
      data['Open'] = open!.map((v) => v.toJson()).toList();
    }
		if (closed != null) {
      data['Closed'] = closed!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class New {
	int? id;
	int? status;
	int? rejectCount;
	String? checklistId;
	int? checkedStatus;
	String? dueDate;
	String? activity;
	String? activityHead;
	int? debitAmount;
	String? contractorName;
	String? closingRemark;
	String? closeDate;
	String? createdAt;
	int? createdBy;
	String? createdByName;
	int? updatedBy;
	String? updatedByName;
	String? debetContractor;
	String? newCheckCode;
	int? linkActivityId;
	String? locationName;
	String? startDate;
	String? endDate;
	String? subLocationName;
	String? subSubLocationName;
	String? closeType;
	String? updatedAt;
	int? progressId;
	int? projectId;
	String? remarks;
	int? draftStatus;
	String? triggerName;
	int? triggerId;
	String? createdTrig;

	New({this.id, this.status, this.rejectCount, this.checklistId, this.checkedStatus, this.dueDate, this.activity, this.activityHead, this.debitAmount, this.contractorName, this.closingRemark, this.closeDate, this.createdAt, this.createdBy, this.createdByName, this.updatedBy, this.updatedByName, this.debetContractor, this.newCheckCode, this.linkActivityId, this.locationName, this.startDate, this.endDate, this.subLocationName, this.subSubLocationName, this.closeType, this.updatedAt, this.progressId, this.projectId, this.remarks, this.draftStatus, this.triggerName, this.triggerId, this.createdTrig});

	New.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		status = json['status'];
		rejectCount = json['reject_count'];
		checklistId = json['checklist_id'];
		checkedStatus = json['checked_status'];
		dueDate = json['due_date'];
		activity = json['activity'];
		activityHead = json['activity_head'];
		debitAmount = json['debit_amount'];
		contractorName = json['contractor_name'];
		closingRemark = json['closing_remark'];
		closeDate = json['close_date'];
		createdAt = json['created_at'];
		createdBy = json['created_by'];
		createdByName = json['created_by_name'];
		updatedBy = json['updated_by'];
		updatedByName = json['updated_by_name'];
		debetContractor = json['debet_contractor'];
		newCheckCode = json['new_check_code'];
		linkActivityId = json['link_activity_id'];
		locationName = json['location_name'];
		startDate = json['start_date'];
		endDate = json['end_date'];
		subLocationName = json['sub_location_name'];
		subSubLocationName = json['sub_sub_location_name'];
		closeType = json['close_type'];
		updatedAt = json['updated_at'];
		progressId = json['progress_id'];
		projectId = json['project_id'];
		remarks = json['remarks'];
		draftStatus = json['draft_status'];
		triggerName = json['trigger_name'];
		triggerId = json['trigger_id'];
		createdTrig = json['created_trig'];     
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['status'] = status;
		data['reject_count'] = rejectCount;
		data['checklist_id'] = checklistId;
		data['checked_status'] = checkedStatus;
		data['due_date'] = dueDate;
		data['activity'] = activity;
		data['activity_head'] = activityHead;
		data['debit_amount'] = debitAmount;
		data['contractor_name'] = contractorName;
		data['closing_remark'] = closingRemark;
		data['close_date'] = closeDate;
		data['created_at'] = createdAt;
		data['created_by'] = createdBy;
		data['created_by_name'] = createdByName;
		data['updated_by'] = updatedBy;
		data['updated_by_name'] = updatedByName;
		data['debet_contractor'] = debetContractor;
		data['new_check_code'] = newCheckCode;
		data['link_activity_id'] = linkActivityId;
		data['location_name'] = locationName;
		data['start_date'] = startDate;
		data['end_date'] = endDate;
		data['sub_location_name'] = subLocationName;
		data['sub_sub_location_name'] = subSubLocationName;
		data['close_type'] = closeType;
		data['updated_at'] = updatedAt;
		data['progress_id'] = progressId;
		data['project_id'] = projectId;
		data['remarks'] = remarks;
		data['draft_status'] = draftStatus;
		data['trigger_name'] = triggerName;
		data['trigger_id'] = triggerId;
		data['created_trig'] = createdTrig;
		return data;
	}
}

class Open {
	int? id;
	int? status;
	int? rejectCount;
	String? checklistId;
	int? checkedStatus;
	String? dueDate;
	String? activity;
	String? activityHead;
	int? debitAmount;
	String? contractorName;
	String? closingRemark;
	String? closeDate;
	String? createdAt;
	int? createdBy;
	String? createdByName;
	int? updatedBy;
	String? updatedByName;
	String? debetContractor;
	String? newCheckCode;
	int? linkActivityId;
	String? locationName;
	String? startDate;
	String? endDate;
	String? subLocationName;
	String? subSubLocationName;
	String? closeType;
	String? updatedAt;
	int? progressId;
	int? projectId;
	String? remarks;
	int? draftStatus;
	String? triggerName;
	int? triggerId;
	String? createdTrig;

	Open({this.id, this.status, this.rejectCount, this.checklistId, this.checkedStatus, this.dueDate, this.activity, this.activityHead, this.debitAmount, this.contractorName, this.closingRemark, this.closeDate, this.createdAt, this.createdBy, this.createdByName, this.updatedBy, this.updatedByName, this.debetContractor, this.newCheckCode, this.linkActivityId, this.locationName, this.startDate, this.endDate, this.subLocationName, this.subSubLocationName, this.closeType, this.updatedAt, this.progressId, this.projectId, this.remarks, this.draftStatus, this.triggerName, this.triggerId, this.createdTrig});

	Open.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		status = json['status'];
		rejectCount = json['reject_count'];
		checklistId = json['checklist_id'];
		checkedStatus = json['checked_status'];
		dueDate = json['due_date'];
		activity = json['activity'];
		activityHead = json['activity_head'];
		debitAmount = json['debit_amount'];
		contractorName = json['contractor_name'];
		closingRemark = json['closing_remark'];
		closeDate = json['close_date'];
		createdAt = json['created_at'];
		createdBy = json['created_by'];
		createdByName = json['created_by_name'];
		updatedBy = json['updated_by'];
		updatedByName = json['updated_by_name'];
		debetContractor = json['debet_contractor'];
		newCheckCode = json['new_check_code'];
		linkActivityId = json['link_activity_id'];
		locationName = json['location_name'];
		startDate = json['start_date'];
		endDate = json['end_date'];
		subLocationName = json['sub_location_name'];
		subSubLocationName = json['sub_sub_location_name'];
		closeType = json['close_type'];
		updatedAt = json['updated_at'];
		progressId = json['progress_id'];
		projectId = json['project_id'];
		remarks = json['remarks'];
		draftStatus = json['draft_status'];
		triggerName = json['trigger_name'];
		triggerId = json['trigger_id'];
		createdTrig = json['created_trig'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['status'] = status;
		data['reject_count'] = rejectCount;
		data['checklist_id'] = checklistId;
		data['checked_status'] = checkedStatus;
		data['due_date'] = dueDate;
		data['activity'] = activity;
		data['activity_head'] = activityHead;
		data['debit_amount'] = debitAmount;
		data['contractor_name'] = contractorName;
		data['closing_remark'] = closingRemark;
		data['close_date'] = closeDate;
		data['created_at'] = createdAt;
		data['created_by'] = createdBy;
		data['created_by_name'] = createdByName;
		data['updated_by'] = updatedBy;
		data['updated_by_name'] = updatedByName;
		data['debet_contractor'] = debetContractor;
		data['new_check_code'] = newCheckCode;
		data['link_activity_id'] = linkActivityId;
		data['location_name'] = locationName;
		data['start_date'] = startDate;
		data['end_date'] = endDate;
		data['sub_location_name'] = subLocationName;
		data['sub_sub_location_name'] = subSubLocationName;
		data['close_type'] = closeType;
		data['updated_at'] = updatedAt;
		data['progress_id'] = progressId;
		data['project_id'] = projectId;
		data['remarks'] = remarks;
		data['draft_status'] = draftStatus;
		data['trigger_name'] = triggerName;
		data['trigger_id'] = triggerId;
		data['created_trig'] = createdTrig;
		return data;
	}
}

class Closed {
	int? id;
	int? status;
	int? rejectCount;
	String? checklistId;
	int? checkedStatus;
	String? dueDate;
	String? activity;
	String? activityHead;
	int? debitAmount;
	String? contractorName;
	String? closingRemark;
	String? closeDate;
	String? createdAt;
	int? createdBy;
	String? createdByName;
	int? updatedBy;
	String? updatedByName;
	String? debetContractor;
	String? newCheckCode;
	int? linkActivityId;
	String? locationName;
	String? startDate;
	String? endDate;
	String? subLocationName;
	String? subSubLocationName;
	String? closeType;
	String? updatedAt;
	int? progressId;
	int? projectId;
	String? remarks;
	int? draftStatus;
	String? triggerName;
	int? triggerId;
	String? createdTrig;

	Closed({this.id, this.status, this.rejectCount, this.checklistId, this.checkedStatus, this.dueDate, this.activity, this.activityHead, this.debitAmount, this.contractorName, this.closingRemark, this.closeDate, this.createdAt, this.createdBy, this.createdByName, this.updatedBy, this.updatedByName, this.debetContractor, this.newCheckCode, this.linkActivityId, this.locationName, this.startDate, this.endDate, this.subLocationName, this.subSubLocationName, this.closeType, this.updatedAt, this.progressId, this.projectId, this.remarks, this.draftStatus, this.triggerName, this.triggerId, this.createdTrig});

	Closed.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		status = json['status'];
		rejectCount = json['reject_count'];
		checklistId = json['checklist_id'];
		checkedStatus = json['checked_status'];
		dueDate = json['due_date'];
		activity = json['activity'];
		activityHead = json['activity_head'];
		debitAmount = json['debit_amount'];
		contractorName = json['contractor_name'];
		closingRemark = json['closing_remark'];
		closeDate = json['close_date'];
		createdAt = json['created_at'];
		createdBy = json['created_by'];
		createdByName = json['created_by_name'];
		updatedBy = json['updated_by'];
		updatedByName = json['updated_by_name'];
		debetContractor = json['debet_contractor'];
		newCheckCode = json['new_check_code'];
		linkActivityId = json['link_activity_id'];
		locationName = json['location_name'];
		startDate = json['start_date'];
		endDate = json['end_date'];
		subLocationName = json['sub_location_name'];
		subSubLocationName = json['sub_sub_location_name'];
		closeType = json['close_type'];
		updatedAt = json['updated_at'];
		progressId = json['progress_id'];
		projectId = json['project_id'];
		remarks = json['remarks'];
		draftStatus = json['draft_status'];
		triggerName = json['trigger_name'];
		triggerId = json['trigger_id'];
		createdTrig = json['created_trig'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['status'] = status;
		data['reject_count'] = rejectCount;
		data['checklist_id'] = checklistId;
		data['checked_status'] = checkedStatus;
		data['due_date'] = dueDate;
		data['activity'] = activity;
		data['activity_head'] = activityHead;
		data['debit_amount'] = debitAmount;
		data['contractor_name'] = contractorName;
		data['closing_remark'] = closingRemark;
		data['close_date'] = closeDate;
		data['created_at'] = createdAt;
		data['created_by'] = createdBy;
		data['created_by_name'] = createdByName;
		data['updated_by'] = updatedBy;
		data['updated_by_name'] = updatedByName;
		data['debet_contractor'] = debetContractor;
		data['new_check_code'] = newCheckCode;
		data['link_activity_id'] = linkActivityId;
		data['location_name'] = locationName;
		data['start_date'] = startDate;
		data['end_date'] = endDate;
		data['sub_location_name'] = subLocationName;
		data['sub_sub_location_name'] = subSubLocationName;
		data['close_type'] = closeType;
		data['updated_at'] = updatedAt;
		data['progress_id'] = progressId;
		data['project_id'] = projectId;
		data['remarks'] = remarks;
		data['draft_status'] = draftStatus;
		data['trigger_name'] = triggerName;
		data['trigger_id'] = triggerId;
		data['created_trig'] = createdTrig;
		return data;
	}
}