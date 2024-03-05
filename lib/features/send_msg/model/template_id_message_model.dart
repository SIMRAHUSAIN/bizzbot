class TemplateIdMessageModel {
  int? statusCode;
  String? error;
  List<Data>? data;

  TemplateIdMessageModel({this.statusCode, this.error, this.data});

  TemplateIdMessageModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
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
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  int? templateID;
  String? tbodytext;
  int? nId;
  String? userId;
  String? tName;
  String? tType;
  String? tCategory;
  String? tLanguage;
  String? msgText;
  String? caption;
  String? fileUploadOrURL;
  String? uRL;
  String? fileupload;
  String? filename;
  String? requestDate;
  String? allotorReject;
  String? allotorRejectBy;
  String? allotorRejectDate;
  bool? isActive;
  String? insertDateTime;
  String? tHeadType;
  String? tHeadText;
  String? tFootText;
  String? tBodyText1;
  double? tHeadLocLatitude;
  double? tHeadLocLongitude;
  int? tButton1Id;
  String? tButton1Title;
  int? tButton2Id;
  String? tButton2Title;
  int? tButton3Id;
  String? tButton3Title;
  String? tListTitle;
  String? phone;
  String? vartBodyText;
  String? btnAutoReply1;
  String? btnAutoReply2;
  String? btnAutoReply3;
  String? btnType;
  String? cTAURL;
  String? cTAPHONENO;
  String? cTACOUNTRYCODE;
  bool? enableScratch;
  bool? connectAgent;
  String? connectAgentCode;
  String? ctaCallStaticOrDynamic;
  String? ctaUrlStaticOrDynamic;

  Data(
      {this.name,
        this.templateID,
        this.tbodytext,
        this.nId,
        this.userId,
        this.tName,
        this.tType,
        this.tCategory,
        this.tLanguage,
        this.msgText,
        this.caption,
        this.fileUploadOrURL,
        this.uRL,
        this.fileupload,
        this.filename,
        this.requestDate,
        this.allotorReject,
        this.allotorRejectBy,
        this.allotorRejectDate,
        this.isActive,
        this.insertDateTime,
        this.tHeadType,
        this.tHeadText,
        this.tFootText,
        this.tBodyText1,
        this.tHeadLocLatitude,
        this.tHeadLocLongitude,
        this.tButton1Id,
        this.tButton1Title,
        this.tButton2Id,
        this.tButton2Title,
        this.tButton3Id,
        this.tButton3Title,
        this.tListTitle,
        this.phone,
        this.vartBodyText,
        this.btnAutoReply1,
        this.btnAutoReply2,
        this.btnAutoReply3,
        this.btnType,
        this.cTAURL,
        this.cTAPHONENO,
        this.cTACOUNTRYCODE,
        this.enableScratch,
        this.connectAgent,
        this.connectAgentCode,
        this.ctaCallStaticOrDynamic,
        this.ctaUrlStaticOrDynamic});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    templateID = json['TemplateID'];
    tbodytext = json['tbodytext'];
    nId = json['nId'];
    userId = json['UserId'];
    tName = json['tName'];
    tType = json['tType'];
    tCategory = json['tCategory'];
    tLanguage = json['tLanguage'];
    msgText = json['MsgText'];
    caption = json['caption'];
    fileUploadOrURL = json['FileUploadOrURL'];
    uRL = json['URL'];
    fileupload = json['fileupload'];
    filename = json['filename'];
    requestDate = json['RequestDate'];
    allotorReject = json['AllotorReject'];
    allotorRejectBy = json['AllotorRejectBy'];
    allotorRejectDate = json['AllotorRejectDate'];
    isActive = json['IsActive'];
    insertDateTime = json['InsertDateTime'];
    tHeadType = json['tHeadType'];
    tHeadText = json['tHeadText'];
    tFootText = json['tFootText'];
    tBodyText1 = json['tBodyText1'];
    tHeadLocLatitude = json['tHeadLocLatitude'];
    tHeadLocLongitude = json['tHeadLocLongitude'];
    tButton1Id = json['tButton1Id'];
    tButton1Title = json['tButton1Title'];
    tButton2Id = json['tButton2Id'];
    tButton2Title = json['tButton2Title'];
    tButton3Id = json['tButton3Id'];
    tButton3Title = json['tButton3Title'];
    tListTitle = json['tListTitle'];
    phone = json['Phone'];
    vartBodyText = json['VartBodyText'];
    btnAutoReply1 = json['btnAutoReply1'];
    btnAutoReply2 = json['btnAutoReply2'];
    btnAutoReply3 = json['btnAutoReply3'];
    btnType = json['btnType'];
    cTAURL = json['CTA_URL'];
    cTAPHONENO = json['CTA_PHONENO'];
    cTACOUNTRYCODE = json['CTA_COUNTRYCODE'];
    enableScratch = json['EnableScratch'];
    connectAgent = json['Connect_Agent'];
    connectAgentCode = json['Connect_Agent_Code'];
    ctaCallStaticOrDynamic = json['ctaCallStaticOrDynamic'];
    ctaUrlStaticOrDynamic = json['ctaUrlStaticOrDynamic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['TemplateID'] = this.templateID;
    data['tbodytext'] = this.tbodytext;
    data['nId'] = this.nId;
    data['UserId'] = this.userId;
    data['tName'] = this.tName;
    data['tType'] = this.tType;
    data['tCategory'] = this.tCategory;
    data['tLanguage'] = this.tLanguage;
    data['MsgText'] = this.msgText;
    data['caption'] = this.caption;
    data['FileUploadOrURL'] = this.fileUploadOrURL;
    data['URL'] = this.uRL;
    data['fileupload'] = this.fileupload;
    data['filename'] = this.filename;
    data['RequestDate'] = this.requestDate;
    data['AllotorReject'] = this.allotorReject;
    data['AllotorRejectBy'] = this.allotorRejectBy;
    data['AllotorRejectDate'] = this.allotorRejectDate;
    data['IsActive'] = this.isActive;
    data['InsertDateTime'] = this.insertDateTime;
    data['tHeadType'] = this.tHeadType;
    data['tHeadText'] = this.tHeadText;
    data['tFootText'] = this.tFootText;
    data['tBodyText1'] = this.tBodyText1;
    data['tHeadLocLatitude'] = this.tHeadLocLatitude;
    data['tHeadLocLongitude'] = this.tHeadLocLongitude;
    data['tButton1Id'] = this.tButton1Id;
    data['tButton1Title'] = this.tButton1Title;
    data['tButton2Id'] = this.tButton2Id;
    data['tButton2Title'] = this.tButton2Title;
    data['tButton3Id'] = this.tButton3Id;
    data['tButton3Title'] = this.tButton3Title;
    data['tListTitle'] = this.tListTitle;
    data['Phone'] = this.phone;
    data['VartBodyText'] = this.vartBodyText;
    data['btnAutoReply1'] = this.btnAutoReply1;
    data['btnAutoReply2'] = this.btnAutoReply2;
    data['btnAutoReply3'] = this.btnAutoReply3;
    data['btnType'] = this.btnType;
    data['CTA_URL'] = this.cTAURL;
    data['CTA_PHONENO'] = this.cTAPHONENO;
    data['CTA_COUNTRYCODE'] = this.cTACOUNTRYCODE;
    data['EnableScratch'] = this.enableScratch;
    data['Connect_Agent'] = this.connectAgent;
    data['Connect_Agent_Code'] = this.connectAgentCode;
    data['ctaCallStaticOrDynamic'] = this.ctaCallStaticOrDynamic;
    data['ctaUrlStaticOrDynamic'] = this.ctaUrlStaticOrDynamic;
    return data;
  }
}