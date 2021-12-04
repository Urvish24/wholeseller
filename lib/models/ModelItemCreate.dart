class ModelItemCreate {
  int code;
  bool status;
  String message;
  List<Data> data;

  ModelItemCreate({this.code, this.status, this.message, this.data});

  ModelItemCreate.fromJson(Map<String, dynamic> json) {
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
  bool itmIsDeleted;
  String sId;
  String itmName;
  String itmId;
  String itmImageType;
  String itmImageName;
  String itmPrice;
  String itmCreatedAt;
  String itmUpdatedAt;

  Data(
      {this.itmIsDeleted,
      this.sId,
      this.itmName,
      this.itmId,
      this.itmImageType,
      this.itmImageName,
      this.itmPrice,
      this.itmCreatedAt,
      this.itmUpdatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    itmIsDeleted = json['itm_is_deleted'];
    sId = json['_id'];
    itmName = json['itm_name'];
    itmId = json['itm_id'];
    itmImageType = json['itm_image_type'];
    itmImageName = json['itm_image_name'];
    itmPrice = json['itm_price'];
    itmCreatedAt = json['itm_created_at'];
    itmUpdatedAt = json['itm_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itm_is_deleted'] = this.itmIsDeleted;
    data['_id'] = this.sId;
    data['itm_name'] = this.itmName;
    data['itm_id'] = this.itmId;
    data['itm_image_type'] = this.itmImageType;
    data['itm_image_name'] = this.itmImageName;
    data['itm_price'] = this.itmPrice;
    data['itm_created_at'] = this.itmCreatedAt;
    data['itm_updated_at'] = this.itmUpdatedAt;
    return data;
  }
}
