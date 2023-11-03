class LoginModel {
  int? status;
  List<LoginModelSuccess>? success;

  LoginModel({
    this.status,
    this.success,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json["statusCode"];
    success = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["statusCode"] = status;
    if (success != null) {
      data['data'] = success!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoginModelSuccess {
  String? agentUsrNm;
  String? agentId;
  String? userNm;
  String? wabaBlnc;
  String? usrTyp;
  String? smsBal;
  String? urlBlnc;
  String? noOfHit;
  String? urlRate;
  String? dltChrg;
  String? rateNrmlSms;
  String? rateSmrtSms;
  String? rateCmpgn;
  String? rateOtp;
  String? email;
  String? ccEmail;
  String? mobile;
  String? domainNm;
  String? shwSmsDlr;
  String? shwMobxx;
  String? dftCntry;
  String? dltNo;
  String? aRuthKy;
  String? apiUrl;
  String? wabaNo;
  String? wabaId;
  String? hsmId;
  String? hsmPwd;
  String? prvdrNm;
  String? wabaMobNum;
  String? prflImagePth;
  String? wabaMobNo;
  String? agentMob;

  LoginModelSuccess({
    this.aRuthKy,
    this.agentId,
    this.agentMob,
    this.agentUsrNm,
    this.apiUrl,
    this.ccEmail,
    this.dftCntry,
    this.dltChrg,
    this.dltNo,
    this.domainNm,
    this.email,
    this.hsmId,
    this.hsmPwd,
    this.mobile,
    this.noOfHit,
    this.prflImagePth,
    this.prvdrNm,
    this.rateCmpgn,
    this.rateNrmlSms,
    this.rateSmrtSms,
    this.rateOtp,
    this.shwMobxx,
    this.shwSmsDlr,
    this.smsBal,
    this.urlBlnc,
    this.urlRate,
    this.userNm,
    this.usrTyp,
    this.wabaBlnc,
    this.wabaId,
    this.wabaMobNo,
  });

  LoginModelSuccess.fromJson(Map<String, dynamic> json) {
    agentUsrNm = json["AgentUserName"];
    agentId = json["AgentId"];
    userNm = json["UserName"];
    wabaBlnc = json["WabaBalance"];
    usrTyp = json["UserType"];
    smsBal = json["SmsBal"];
    urlBlnc = json["UrlBalance"];
    noOfHit = json["NoOfhit"];
    urlRate = json["UrlRate"];
    dltChrg = json["DltCharge"];
    rateNrmlSms = json["RateNormalSms"];
    rateSmrtSms = json["RateSmartSms"];
    rateCmpgn = json["RateCampaign"];
    rateOtp = json["rateOtp"];
    email = json["Email"];
    ccEmail = json["CCEmail"];
    mobile = json["Mobile"];
    domainNm = json["DomainName"];
    shwSmsDlr = json["ShowSmsDLR"];
    shwMobxx = json["ShowMobilexxxx"];
    dftCntry = json["DefaultCountry"];
    dltNo = json["DltNo"];
    aRuthKy = json["AruthKey"];
    apiUrl = json["ApiUrl"];
    wabaNo = json["WabaNo"];
    wabaId = json["WabaId"];
    hsmId = json["HsmId"];
    hsmPwd = json["HsmPwd"];
    prvdrNm = json["ProviderName"];
    wabaMobNum = json["WabaMobileNumber"];
    prflImagePth = json["ProfileImagePath"];
    wabaMobNo = json["WabaMobileNo"];
    agentMob = json["AgentMobile"];
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["AgentUserName"] = agentUsrNm;
    data["AgentId"] = agentId;
    data["UserName"] = userNm;
    data["WabaBalance"] = wabaBlnc;
    data["UserType"] = usrTyp;
    data["SmsBal"] = smsBal;
    data["UrlBalance"] = urlBlnc;
    data["NoOfhit"] = noOfHit;
    data["UrlRate"] = urlRate;
    data["DltCharge"] = dltChrg;
    data["RateNormalSms"] = rateNrmlSms;
    data["RateSmartSms"] = rateSmrtSms;
    data["RateCampaign"] = rateCmpgn;
    data["rateOtp"] = rateOtp;
    data["Email"] = email;
    data["CCEmail"] = ccEmail;
    data["Mobile"] = mobile;
    data["DomainName"] = domainNm;
    data["ShowSmsDLR"] = shwSmsDlr;
    data["ShowMobilexxxx"] = shwMobxx;
    data["DefaultCountry"] = dftCntry;
    data["DltNo"] = dltNo;
    data["AruthKey"] = aRuthKy;
    data["ApiUrl"] = apiUrl;
    data["WabaNo"] = wabaNo;
    data["WabaId"] = wabaId;
    data["HsmId"] = hsmId;
    data["HsmPwd"] = hsmPwd;
    data["ProviderName"] = prvdrNm;
    data["WabaMobileNumber"] = wabaMobNum;
    data["ProfileImagePath"] = prflImagePth;
    data["WabaMobileNo"] = wabaMobNo;
    data["AgentMobile"] = agentMob;
    return data;
  }
}