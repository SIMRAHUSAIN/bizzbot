class UserChatModel {
  String? statusCode;
  List<Data>? data;

  UserChatModel({this.statusCode, this.data});

  UserChatModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return 'UserChatModel{statusCode: $statusCode, data: $data}';
  }
}

class Data {
  String? sno;
  String? contact;
  String? fromMob;
  String? inserttime;
  String? messagetext;
  String? toMob;
  String? msgCount;
  String? ssn;
  String? hasDiff;
  String? insertdatetime;
  String? flag1nm;
  String? flag2nm;
  String? flag3nm;
  String? flag1col;
  String? flag2col;
  String? flag3col;
  String? flagplus;

  Data(
      {this.sno,
        this.contact,
        this.fromMob,
        this.inserttime,
        this.messagetext,
        this.toMob,
        this.msgCount,
        this.ssn,
        this.hasDiff,
        this.insertdatetime,
        this.flag1nm,
        this.flag2nm,
        this.flag3nm,
        this.flag1col,
        this.flag2col,
        this.flag3col,
        this.flagplus});

  Data.fromJson(Map<String, dynamic> json) {
    sno = json['Sno'];
    contact = json['Contact'];
    fromMob = json['fromMob'];
    inserttime = json['inserttime'];
    messagetext = json['messagetext'];
    toMob = json['toMob'];
    msgCount = json['MsgCount'];
    ssn = json['ssn'];
    hasDiff = json['has_diff'];
    insertdatetime = json['insertdatetime'];
    flag1nm = json['flag1nm'];
    flag2nm = json['flag2nm'];
    flag3nm = json['flag3nm'];
    flag1col = json['flag1col'];
    flag2col = json['flag2col'];
    flag3col = json['flag3col'];
    flagplus = json['flagplus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Sno'] = sno;
    data['Contact'] = contact;
    data['fromMob'] = fromMob;
    data['inserttime'] = inserttime;
    data['messagetext'] = messagetext;
    data['toMob'] = toMob;
    data['MsgCount'] = msgCount;
    data['ssn'] = ssn;
    data['has_diff'] = hasDiff;
    data['insertdatetime'] = insertdatetime;
    data['flag1nm'] = flag1nm;
    data['flag2nm'] = flag2nm;
    data['flag3nm'] = flag3nm;
    data['flag1col'] = flag1col;
    data['flag2col'] = flag2col;
    data['flag3col'] = flag3col;
    data['flagplus'] = flagplus;
    return data;
  }

  @override
  String toString() {
    return 'Data{sno: $sno, contact: $contact, fromMob: $fromMob, inserttime: $inserttime, messagetext: $messagetext, toMob: $toMob, msgCount: $msgCount, ssn: $ssn, hasDiff: $hasDiff, insertdatetime: $insertdatetime, flag1nm: $flag1nm, flag2nm: $flag2nm, flag3nm: $flag3nm, flag1col: $flag1col, flag2col: $flag2col, flag3col: $flag3col, flagplus: $flagplus}';
  }
}