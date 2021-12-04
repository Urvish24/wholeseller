class CustomerListModel {
  int code;
  bool status;
  String message;
  List<Data> data;

  CustomerListModel({this.code, this.status, this.message, this.data});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String usrRole;
  String usrStatus;
  bool usrIsDeleted;
  String usrName;
  String usrBusinessName;
  String usrPhoneNumber;
  String usrCustomerId;
  String usrStateId;
  String usrPassword;
  String usrCreatedAt;
  String usrUpdatedAt;
  List<StateDetail> stateDetail;
  String usrDeviceToken;
  String usrJwt;

  Data(
      {this.sId,
        this.usrRole,
        this.usrStatus,
        this.usrIsDeleted,
        this.usrName,
        this.usrBusinessName,
        this.usrPhoneNumber,
        this.usrCustomerId,
        this.usrStateId,
        this.usrPassword,
        this.usrCreatedAt,
        this.usrUpdatedAt,
        this.stateDetail,
        this.usrDeviceToken,
        this.usrJwt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    usrRole = json['usr_role'];
    usrStatus = json['usr_status'];
    usrIsDeleted = json['usr_is_deleted'];
    usrName = json['usr_name'];
    usrBusinessName = json['usr_business_name'];
    usrPhoneNumber = json['usr_phone_number'];
    usrCustomerId = json['usr_customer_id'];
    //usrStateId = json['usr_state_id'];
    usrPassword = json['usr_password'];
    usrCreatedAt = json['usr_created_at'];
    usrUpdatedAt = json['usr_updated_at'];
    if (json['stateDetail'] != null) {
      stateDetail = new List<StateDetail>();
      json['stateDetail'].forEach((v) {
        stateDetail.add(new StateDetail.fromJson(v));
      });
    }
    usrDeviceToken = json['usr_device_token'];
    usrJwt = json['usr_jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['usr_role'] = this.usrRole;
    data['usr_status'] = this.usrStatus;
    data['usr_is_deleted'] = this.usrIsDeleted;
    data['usr_name'] = this.usrName;
    data['usr_business_name'] = this.usrBusinessName;
    data['usr_phone_number'] = this.usrPhoneNumber;
    data['usr_customer_id'] = this.usrCustomerId;
    /*data['usr_state_id'] = this.usrStateId;*/
    data['usr_password'] = this.usrPassword;
    data['usr_created_at'] = this.usrCreatedAt;
    data['usr_updated_at'] = this.usrUpdatedAt;
    if (this.stateDetail != null) {
      data['stateDetail'] = this.stateDetail.map((v) => v.toJson()).toList();
    }
    data['usr_device_token'] = this.usrDeviceToken;
    data['usr_jwt'] = this.usrJwt;
    return data;
  }
}

class StateDetail {
  String sId;
  bool stIsDeleted;
  String stName;
  String stCreatedAt;
  String stUpdatedAt;

  StateDetail(
      {this.sId,
        this.stIsDeleted,
        this.stName,
        this.stCreatedAt,
        this.stUpdatedAt});

  StateDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    stIsDeleted = json['st_is_deleted'];
    stName = json['st_name'];
    stCreatedAt = json['st_created_at'];
    stUpdatedAt = json['st_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['st_is_deleted'] = this.stIsDeleted;
    data['st_name'] = this.stName;
    data['st_created_at'] = this.stCreatedAt;
    data['st_updated_at'] = this.stUpdatedAt;
    return data;
  }
}