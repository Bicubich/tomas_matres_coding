class PartnerModel {
  List<Message>? message;
  List<Partner>? manufacturers;

  PartnerModel({this.message, this.manufacturers});

  PartnerModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v));
      });
    }
    if (json['manufacturers'] != null) {
      manufacturers = <Partner>[];
      json['manufacturers'].forEach((v) {
        manufacturers!.add(Partner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.map((v) => v.toJson()).toList();
    }
    if (manufacturers != null) {
      data['manufacturers'] = manufacturers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? msg;
  bool? msgStatus;

  Message({this.msg, this.msgStatus});

  Message.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    msgStatus = json['msg_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['msg'] = msg;
    data['msg_status'] = msgStatus;
    return data;
  }
}

class Partner {
  String? manufacturerId;
  String? name;
  String? image;
  String? sortOrder;
  String? storeId;
  String? href;

  Partner(
      {this.manufacturerId,
      this.name,
      this.image,
      this.sortOrder,
      this.storeId,
      this.href});

  Partner.fromJson(Map<String, dynamic> json) {
    manufacturerId = json['manufacturer_id'];
    name = json['name'];
    image = json['image'];
    sortOrder = json['sort_order'];
    storeId = json['store_id'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manufacturer_id'] = manufacturerId;
    data['name'] = name;
    data['image'] = image;
    data['sort_order'] = sortOrder;
    data['store_id'] = storeId;
    data['href'] = href;
    return data;
  }
}
