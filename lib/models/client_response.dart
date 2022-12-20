class DonutArr {
    int? workDone;
    int? balance;

    DonutArr({this.workDone, this.balance}); 

    DonutArr.fromJson(Map<String, dynamic> json) {
        workDone = json['workDone'];
        balance = json['Balance'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['workDone'] = workDone;
        data['Balance'] = balance;
        return data;
    }
}

class NonProductiveCount {
    int? misscount;

    NonProductiveCount({this.misscount}); 

    NonProductiveCount.fromJson(Map<String, dynamic> json) {
        misscount = json['miss_count'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['miss_count'] = misscount;
        return data;
    }
}

class ProductiveCount {
    int? prodcount;

    ProductiveCount({this.prodcount}); 

    ProductiveCount.fromJson(Map<String, dynamic> json) {
        prodcount = json['prod_count'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['prod_count'] = prodcount;
        return data;
    }
}

class ClientProfileData {
    int? clientid;
    int? projectid;
    int? companyid;
    String? projectname;
    String? projectgroupname;
    int? projecttype;
    String? phase;
    String? website;
    int? country;
    int? state;
    String? geocordinates;
    String? projectvideourl;
    int? contracttype;
    String? projectowner;
    String? projectstatedate;
    String? projectenddate;
    String? billStartdate;
    num? projectstatus;
    String? projectlogoname;
    num? createdby;
    num? updatedby;
    String? createdat;
    String? updatedat;
    num? snagCount;
    num? progressPrwCount;
    num? progressMissCount;
    num? progressDepartCount;
    num? areaOfConern;
    List<DonutArr?>? donutArr;
    List<NonProductiveCount?>? nonProductiveCount;
    List<ProductiveCount?>? productiveCount;
    num? snagTotalCount;
    num? areaOfConernTotal;
    num? totalPwrLabourCount;
    num? totalDeptLabourCount;
    num? totalMisscLabourCount;

    ClientProfileData({this.clientid, this.projectid, this.companyid, this.projectname, this.projectgroupname, this.projecttype, this.phase, this.website, this.country, this.state, this.geocordinates, this.projectvideourl, this.contracttype, this.projectowner, this.projectstatedate, this.projectenddate, this.billStartdate, this.projectstatus, this.projectlogoname, this.createdby, this.updatedby, this.createdat, this.updatedat, this.snagCount, this.progressPrwCount, this.progressMissCount, this.progressDepartCount, this.areaOfConern, this.donutArr, this.nonProductiveCount, this.productiveCount, this.snagTotalCount, this.areaOfConernTotal, this.totalPwrLabourCount, this.totalDeptLabourCount, this.totalMisscLabourCount}); 

    ClientProfileData.fromJson(Map<String, dynamic> json) {
        clientid = json['client_id'];
        projectid = json['project_id'];
        companyid = json['company_id'];
        projectname = json['project_name'];
        projectgroupname = json['project_group_name'];
        projecttype = json['project_type'];
        phase = json['phase'];
        website = json['website'];
        country = json['country'];
        state = json['state'];
        geocordinates = json['geo_cordinates'];
        projectvideourl = json['project_video_url'];
        contracttype = json['contract_type'];
        projectowner = json['project_owner'];
        projectstatedate = json['project_state_date'];
        projectenddate = json['project_end_date'];
        billStartdate = json['bill_Start_date'];
        projectstatus = json['project_status'];
        projectlogoname = json['project_logo_name'];
        createdby = json['created_by'];
        updatedby = json['updated_by'];
        createdat = json['created_at'];
        updatedat = json['updated_at'];
        snagCount = json['snagCount'];
        progressPrwCount = json['progressPrwCount'];
        progressMissCount = json['progressMissCount'];
        progressDepartCount = json['progressDepartCount'];
        areaOfConern = json['AreaOfConern'];
        if (json['DonutArr'] != null) {
         donutArr = <DonutArr>[];
         json['DonutArr'].forEach((v) {
         donutArr!.add(DonutArr.fromJson(v));
        });
      }
        if (json['nonProductiveCount'] != null) {
         nonProductiveCount = <NonProductiveCount>[];
         json['nonProductiveCount'].forEach((v) {
         nonProductiveCount!.add(NonProductiveCount.fromJson(v));
        });
      }
        if (json['productiveCount'] != null) {
         productiveCount = <ProductiveCount>[];
         json['productiveCount'].forEach((v) {
         productiveCount!.add(ProductiveCount.fromJson(v));
        });
      }
        snagTotalCount = json['snagTotalCount'];
        areaOfConernTotal = json['AreaOfConernTotal'];
        totalPwrLabourCount = json['TotalPwrLabourCount'];
        totalDeptLabourCount = json['TotalDeptLabourCount'];
        totalMisscLabourCount = json['TotalMisscLabourCount'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['client_id'] = clientid;
        data['project_id'] = projectid;
        data['company_id'] = companyid;
        data['project_name'] = projectname;
        data['project_group_name'] = projectgroupname;
        data['project_type'] = projecttype;
        data['phase'] = phase;
        data['website'] = website;
        data['country'] = country;
        data['state'] = state;
        data['geo_cordinates'] = geocordinates;
        data['project_video_url'] = projectvideourl;
        data['contract_type'] = contracttype;
        data['project_owner'] = projectowner;
        data['project_state_date'] = projectstatedate;
        data['project_end_date'] = projectenddate;
        data['bill_Start_date'] = billStartdate;
        data['project_status'] = projectstatus;
        data['project_logo_name'] = projectlogoname;
        data['created_by'] = createdby;
        data['updated_by'] = updatedby;
        data['created_at'] = createdat;
        data['updated_at'] = updatedat;
        data['snagCount'] = snagCount;
        data['progressPrwCount'] = progressPrwCount;
        data['progressMissCount'] = progressMissCount;
        data['progressDepartCount'] = progressDepartCount;
        data['AreaOfConern'] = areaOfConern;
        data['DonutArr'] =DonutArr != null ? donutArr!.map((v) => v?.toJson()).toList() : null;
        data['nonProductiveCount'] =nonProductiveCount != null ? nonProductiveCount!.map((v) => v?.toJson()).toList() : null;
        data['productiveCount'] =productiveCount != null ? productiveCount!.map((v) => v?.toJson()).toList() : null;
        data['snagTotalCount'] = snagTotalCount;
        data['AreaOfConernTotal'] = areaOfConernTotal;
        data['TotalPwrLabourCount'] = totalPwrLabourCount;
        data['TotalDeptLabourCount'] = totalDeptLabourCount;
        data['TotalMisscLabourCount'] = totalMisscLabourCount;
        return data;
    }
}

