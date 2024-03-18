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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['TemplateID'] = templateID;
    data['tbodytext'] = tbodytext;
    data['nId'] = nId;
    data['UserId'] = userId;
    data['tName'] = tName;
    data['tType'] = tType;
    data['tCategory'] = tCategory;
    data['tLanguage'] = tLanguage;
    data['MsgText'] = msgText;
    data['caption'] = caption;
    data['FileUploadOrURL'] = fileUploadOrURL;
    data['URL'] = uRL;
    data['fileupload'] = fileupload;
    data['filename'] = filename;
    data['RequestDate'] = requestDate;
    data['AllotorReject'] = allotorReject;
    data['AllotorRejectBy'] = allotorRejectBy;
    data['AllotorRejectDate'] = allotorRejectDate;
    data['IsActive'] = isActive;
    data['InsertDateTime'] = insertDateTime;
    data['tHeadType'] = tHeadType;
    data['tHeadText'] = tHeadText;
    data['tFootText'] = tFootText;
    data['tBodyText1'] = tBodyText1;
    data['tHeadLocLatitude'] = tHeadLocLatitude;
    data['tHeadLocLongitude'] = tHeadLocLongitude;
    data['tButton1Id'] = tButton1Id;
    data['tButton1Title'] = tButton1Title;
    data['tButton2Id'] = tButton2Id;
    data['tButton2Title'] = tButton2Title;
    data['tButton3Id'] = tButton3Id;
    data['tButton3Title'] = tButton3Title;
    data['tListTitle'] = tListTitle;
    data['Phone'] = phone;
    data['VartBodyText'] = vartBodyText;
    data['btnAutoReply1'] = btnAutoReply1;
    data['btnAutoReply2'] = btnAutoReply2;
    data['btnAutoReply3'] = btnAutoReply3;
    data['btnType'] = btnType;
    data['CTA_URL'] = cTAURL;
    data['CTA_PHONENO'] = cTAPHONENO;
    data['CTA_COUNTRYCODE'] = cTACOUNTRYCODE;
    data['EnableScratch'] = enableScratch;
    data['Connect_Agent'] = connectAgent;
    data['Connect_Agent_Code'] = connectAgentCode;
    data['ctaCallStaticOrDynamic'] = ctaCallStaticOrDynamic;
    data['ctaUrlStaticOrDynamic'] = ctaUrlStaticOrDynamic;
    return data;
  }
}