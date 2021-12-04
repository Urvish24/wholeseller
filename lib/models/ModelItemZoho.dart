class ModelItemZoho {
  int code;
  bool status;
  String message;
  List<Data> data;

  ModelItemZoho({this.code, this.status, this.message, this.data});

  ModelItemZoho.fromJson(Map<String, dynamic> json) {
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
  String itemId;
  String name;
  String itemName;
  String unit;
  String status;
  String source;
  bool isLinkedWithZohocrm;
  String zcrmProductId;
  String description;
  int rate;
  String taxId;
  List<ItemTaxPreferences> itemTaxPreferences;
  String taxName;
  int taxPercentage;
  String purchaseAccountId;
  String purchaseAccountName;
  String accountName;
  String purchaseDescription;
  int purchaseRate;
  String itemType;
  String productType;
  bool isTaxable;
  String taxExemptionId;
  String taxExemptionCode;
  bool hasAttachment;
  String sku;
  String imageName;
  String imageType;
  String imageDocumentId;
  String createdTime;
  String lastModifiedTime;
  String hsnOrSac;
  bool showInStorefront;
  bool selected;
  int qty;
  int pack;
  String reorderLevel;

  Data(
      {this.itemId,
        this.name,
        this.itemName,
        this.unit,
        this.status,
        this.source,
        this.isLinkedWithZohocrm,
        this.zcrmProductId,
        this.description,
        this.rate,
        this.taxId,
        this.itemTaxPreferences,
        this.taxName,
        this.taxPercentage,
        this.purchaseAccountId,
        this.purchaseAccountName,
        this.accountName,
        this.purchaseDescription,
        this.purchaseRate,
        this.itemType,
        this.productType,
        this.isTaxable,
        this.taxExemptionId,
        this.taxExemptionCode,
        this.hasAttachment,
        this.sku,
        this.imageName,
        this.imageType,
        this.imageDocumentId,
        this.createdTime,
        this.lastModifiedTime,
        this.hsnOrSac,
        this.showInStorefront,
        this.selected,
        this.qty,
        this.pack,
        this.reorderLevel});

  Data.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    name = json['name'];
    itemName = json['item_name'];
    unit = json['unit'];
    status = json['status'];
    source = json['source'];
    isLinkedWithZohocrm = json['is_linked_with_zohocrm'];
    zcrmProductId = json['zcrm_product_id'];
    description = json['description'];
    rate = json['rate'];
    taxId = json['tax_id'];
    if (json['item_tax_preferences'] != null) {
      itemTaxPreferences = new List<ItemTaxPreferences>();
      json['item_tax_preferences'].forEach((v) {
        itemTaxPreferences.add(new ItemTaxPreferences.fromJson(v));
      });
    }
    taxName = json['tax_name'];
    taxPercentage = json['tax_percentage'];
    purchaseAccountId = json['purchase_account_id'];
    purchaseAccountName = json['purchase_account_name'];
    accountName = json['account_name'];
    purchaseDescription = json['purchase_description'];
    purchaseRate = json['purchase_rate'];
    itemType = json['item_type'];
    productType = json['product_type'];
    isTaxable = json['is_taxable'];
    taxExemptionId = json['tax_exemption_id'];
    taxExemptionCode = json['tax_exemption_code'];
    hasAttachment = json['has_attachment'];
    sku = json['sku'];
    imageName = json['image_name'];
    imageType = json['image_type'];
    imageDocumentId = json['image_document_id'];
    createdTime = json['created_time'];
    lastModifiedTime = json['last_modified_time'];
    hsnOrSac = json['hsn_or_sac'];
    showInStorefront = json['show_in_storefront'];
    selected = false;
    qty = 1;
    pack = 0;
    reorderLevel = json['reorder_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['item_name'] = this.itemName;
    data['unit'] = this.unit;
    data['status'] = this.status;
    data['source'] = this.source;
    data['is_linked_with_zohocrm'] = this.isLinkedWithZohocrm;
    data['zcrm_product_id'] = this.zcrmProductId;
    data['description'] = this.description;
    data['rate'] = this.rate;
    data['tax_id'] = this.taxId;
    if (this.itemTaxPreferences != null) {
      data['item_tax_preferences'] =
          this.itemTaxPreferences.map((v) => v.toJson()).toList();
    }
    data['tax_name'] = this.taxName;
    data['tax_percentage'] = this.taxPercentage;
    data['purchase_account_id'] = this.purchaseAccountId;
    data['purchase_account_name'] = this.purchaseAccountName;
    data['account_name'] = this.accountName;
    data['purchase_description'] = this.purchaseDescription;
    data['purchase_rate'] = this.purchaseRate;
    data['item_type'] = this.itemType;
    data['product_type'] = this.productType;
    data['is_taxable'] = this.isTaxable;
    data['tax_exemption_id'] = this.taxExemptionId;
    data['tax_exemption_code'] = this.taxExemptionCode;
    data['has_attachment'] = this.hasAttachment;
    data['sku'] = this.sku;
    data['image_name'] = this.imageName;
    data['image_type'] = this.imageType;
    data['image_document_id'] = this.imageDocumentId;
    data['created_time'] = this.createdTime;
    data['last_modified_time'] = this.lastModifiedTime;
    data['hsn_or_sac'] = this.hsnOrSac;
    data['show_in_storefront'] = this.showInStorefront;
    data['reorder_level'] = this.reorderLevel;
    return data;
  }
}

class ItemTaxPreferences {
  String taxSpecification;
  int taxType;
  String taxName;
  int taxPercentage;
  String taxId;

  ItemTaxPreferences(
      {this.taxSpecification,
        this.taxType,
        this.taxName,
        this.taxPercentage,
        this.taxId});

  ItemTaxPreferences.fromJson(Map<String, dynamic> json) {
    taxSpecification = json['tax_specification'];
    taxType = json['tax_type'];
    taxName = json['tax_name'];
    taxPercentage = json['tax_percentage'];
    taxId = json['tax_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_specification'] = this.taxSpecification;
    data['tax_type'] = this.taxType;
    data['tax_name'] = this.taxName;
    data['tax_percentage'] = this.taxPercentage;
    data['tax_id'] = this.taxId;
    return data;
  }
}