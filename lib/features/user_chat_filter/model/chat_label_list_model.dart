class ChatLabelListModel {
  String? statusCode;
  String? error;
  List<Data>? data;

  ChatLabelListModel({this.statusCode, this.data, this.error});

  ChatLabelListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FlagID'] = flagID;
    data['FlagName'] = flagName;
    data['FlagColorCode'] = flagColorCode;
    data['chkbox'] = chkbox;
    return data;
  }
}