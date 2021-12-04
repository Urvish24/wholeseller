class LoginModel {
  int code;
  bool status;
  String message;
  Data data;

  LoginModel({this.code, this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String usrRole;
  List<String> usrStateId;
  String usrStatus;
  bool usrIsDeleted;
  String sId;
  String usrName;
  String usrBusinessName;
  String usrPhoneNumber;
  String usrCustomerId;
  String usrCity;
  String usrPassword;
  String usrCreatedAt;
  String usrUpdatedAt;
  String usrDeviceToken;
  String usrJwt;

  Data(
      {this.usrRole,
        this.usrStateId,
        this.usrStatus,
        this.usrIsDeleted,
        this.sId,
        this.usrName,
        this.usrBusinessName,
        this.usrPhoneNumber,
        this.usrCustomerId,
        this.usrCity,
        this.usrPassword,
        this.usrCreatedAt,
        this.usrUpdatedAt,
        this.usrDeviceToken,
        this.usrJwt});

  Data.fromJson(Map<String, dynamic> json) {
    usrRole = json['usr_role'];
    usrStateId = json['usr_state_id'].cast<String>();
    usrStatus = json['usr_status'];
    usrIsDeleted = json['usr_is_deleted'];
    sId = json['_id'];
    usrName = json['usr_name'];
    usrBusinessName = json['usr_business_name'];
    usrPhoneNumber = json['usr_phone_number'];
    usrCustomerId = json['usr_customer_id'];
    usrCity = json['usr_city'];
    usrPassword = json['usr_password'];
    usrCreatedAt = json['usr_created_at'];
    usrUpdatedAt = json['usr_updated_at'];
    usrDeviceToken = json['usr_device_token'];
    usrJwt = json['usr_jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usr_role'] = this.usrRole;
    data['usr_state_id'] = this.usrStateId;
    data['usr_status'] = this.usrStatus;
    data['usr_is_deleted'] = this.usrIsDeleted;
    data['_id'] = this.sId;
    data['usr_name'] = this.usrName;
    data['usr_business_name'] = this.usrBusinessName;
    data['usr_phone_number'] = this.usrPhoneNumber;
    data['usr_customer_id'] = this.usrCustomerId;
    data['usr_city'] = this.usrCity;
    data['usr_password'] = this.usrPassword;
    data['usr_created_at'] = this.usrCreatedAt;
    data['usr_updated_at'] = this.usrUpdatedAt;
    data['usr_device_token'] = this.usrDeviceToken;
    data['usr_jwt'] = this.usrJwt;
    return data;
  }
}