class ChatLabelListModel {
  String? statusCode;
  List<Data>? data;

  ChatLabelListModel({this.statusCode, this.data});

  ChatLabelListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? flagID;
  String? flagName;
  String? flagColorCode;
  String? chkbox;

  Data({this.flagID, this.flagName, this.flagColorCode, this.chkbox});

  Data.fromJson(Map<String, dynamic> json) {
    flagID = json['FlagID'];
    flagName = json['FlagName'];
    flagColorCode = json['FlagColorCode'];
    chkbox = json['chkbox'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FlagID'] = this.flagID;
    data['FlagName'] = this.flagName;
    data['FlagColorCode'] = this.flagColorCode;
    data['chkbox'] = this.chkbox;
    return data;
  }
}