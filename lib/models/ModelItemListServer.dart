import 'dart:ffi';

class ModelItemListServer {
  int code;
  bool status;
  String message;
  List<Data> data;

  ModelItemListServer({this.code, this.status, this.message, this.data});

  ModelItemListServer.fromJson(Map<String, dynamic> json) {
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
  bool itmIsDeleted;
  String itmName;
  String itmId;
  String lineItemId;
  String itmImageType;
  String itmImageName;
  String itmPrice;
  String itmCreatedAt;
  String itmUpdatedAt;
  int qty;
  int itmNoOfPack;
  bool selected;

  Data(
      {this.sId,
        this.itmIsDeleted,
        this.itmName,
        this.itmId,
        this.lineItemId,
        this.itmImageType,
        this.itmImageName,
        this.itmPrice,
        this.itmCreatedAt,
        this.selected,
        this.qty,
        this.itmNoOfPack,
        this.itmUpdatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itmIsDeleted = json['itm_is_deleted'];
    itmName = json['itm_name'];
    itmId = json['itm_id'];
    lineItemId = "";
    itmImageType = json['itm_image_type'];
    itmImageName = json['itm_image_name'];
    itmPrice = json['itm_price'];
    itmCreatedAt = json['itm_created_at'];
    selected = false;
    qty = int.parse(json['itm_no_of_pack']);
    itmNoOfPack = int.parse(json['itm_no_of_pack']);
    itmUpdatedAt = json['itm_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['itm_is_deleted'] = this.itmIsDeleted;
    data['itm_name'] = this.itmName;
    data['itm_id'] = this.itmId;
    data['itm_image_type'] = this.itmImageType;
    data['itm_image_name'] = this.itmImageName;
    data['itm_price'] = this.itmPrice;
    data['itm_no_of_pack'] = this.itmNoOfPack;
    data['itm_created_at'] = this.itmCreatedAt;
    data['itm_updated_at'] = this.itmUpdatedAt;
    return data;
  }
}