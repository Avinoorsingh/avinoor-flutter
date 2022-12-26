class LoginResponseModel {
    String? rolename;
    int? id;
    int? clientid;
    String? userid;
    String? password;
    String? name;
    String? rm;
    String? mobileno;
    String? emailid;
    int? roleid;
    int? status;
    int? usertype;
    String? lastname;
    int? designation;
    String? altmobileno;
    String? emergencyname;
    String? emergencymobileno;
    String? dob;
    String? doj;
    String? userimage;
    String? fcmtoken;
    String? createdat;
    String? updatedat;
    String? companycorporateaddress;

    LoginResponseModel({this.rolename, this.id, this.clientid, this.userid, this.password, this.name, this.rm, this.mobileno, this.emailid, this.roleid, this.status, this.usertype, this.lastname, this.designation, this.altmobileno, this.emergencyname, this.emergencymobileno, this.dob, this.doj, this.userimage, this.fcmtoken, this.createdat, this.updatedat, this.companycorporateaddress}); 

    LoginResponseModel.fromJson(Map<String, dynamic> json) {
        rolename = json['role_name'];
        id = json['id'];
        clientid = json['client_id'];
        userid = json['user_id'];
        password = json['password'];
        name = json['name'];
        rm = json['rm'];
        mobileno = json['mobile_no'];
        emailid = json['email_id'];
        roleid = json['role_id'];
        status = json['status'];
        usertype = json['user_type'];
        lastname = json['last_name'];
        designation = json['designation'];
        altmobileno = json['alt_mobile_no'];
        emergencyname = json['emergency_name'];
        emergencymobileno = json['emergency_mobile_no'];
        dob = json['dob'];
        doj = json['doj'];
        userimage = json['user_image'];
        fcmtoken = json['fcm_token'];
        createdat = json['created_at'];
        updatedat = json['updated_at'];
        companycorporateaddress = json['company_corporate_address'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['role_name'] = rolename;
        data['id'] = id;
        data['client_id'] = clientid;
        data['user_id'] = userid;
        data['password'] = password;
        data['name'] = name;
        data['rm'] = rm;
        data['mobile_no'] = mobileno;
        data['email_id'] = emailid;
        data['role_id'] = roleid;
        data['status'] = status;
        data['user_type'] = usertype;
        data['last_name'] = lastname;
        data['designation'] = designation;
        data['alt_mobile_no'] = altmobileno;
        data['emergency_name'] = emergencyname;
        data['emergency_mobile_no'] = emergencymobileno;
        data['dob'] = dob;
        data['doj'] = doj;
        data['user_image'] = userimage;
        data['fcm_token'] = fcmtoken;
        data['created_at'] = createdat;
        data['updated_at'] = updatedat;
        data['company_corporate_address'] = companycorporateaddress;
        return data;
    }
}

