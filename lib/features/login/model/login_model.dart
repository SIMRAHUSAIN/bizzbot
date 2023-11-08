class LoginModel {
  int? statusCode;
  LoginSuccessModel? data;

  LoginModel({this.statusCode, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? LoginSuccessModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginSuccessModel {
  String? userName;
  String? wabaBalance;
  String? userType;
  String? smsBal;
  String? urlBalance;
  String? noOfhit;
  String? urlRate;
  String? dltCharge;
  String? rateNormalSms;
  String? rateSmartSms;
  String? rateCampaign;
  String? rateOtp;
  String? email;
  String? cCEmail;
  String? mobile;
  String? domainName;
  String? showSmsDLR;
  String? showMobilexxxx;
  String? defaultCountry;
  String? dltNo;
  String? aruthKey;
  String? apiUrl;
  String? wabaNo;
  String? wabaId;
  String? hsmId;
  String? hsmPwd;
  String? providerName;
  String? wabaMobileNumber;
  String? agentId;
  String? agentMobile;
  String? profileImagePath;

  LoginSuccessModel(
      {this.userName,
      this.wabaBalance,
      this.userType,
      this.smsBal,
      this.urlBalance,
      this.noOfhit,
      this.urlRate,
      this.dltCharge,
      this.rateNormalSms,
      this.rateSmartSms,
      this.rateCampaign,
      this.rateOtp,
      this.email,
      this.cCEmail,
      this.mobile,
      this.domainName,
      this.showSmsDLR,
      this.showMobilexxxx,
      this.defaultCountry,
      this.dltNo,
      this.aruthKey,
      this.apiUrl,
      this.wabaNo,
      this.wabaId,
      this.hsmId,
      this.hsmPwd,
      this.providerName,
      this.wabaMobileNumber,
      this.agentId,
      this.agentMobile,
      this.profileImagePath});

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    wabaBalance = json['WabaBalance'];
    userType = json['UserType'];
    smsBal = json['SmsBal'];
    urlBalance = json['UrlBalance'];
    noOfhit = json['NoOfhit'];
    urlRate = json['UrlRate'];
    dltCharge = json['DltCharge'];
    rateNormalSms = json['RateNormalSms'];
    rateSmartSms = json['RateSmartSms'];
    rateCampaign = json['RateCampaign'];
    rateOtp = json['RateOtp'];
    email = json['Email'];
    cCEmail = json['CCEmail'];
    mobile = json['Mobile'];
    domainName = json['DomainName'];
    showSmsDLR = json['ShowSmsDLR'];
    showMobilexxxx = json['ShowMobilexxxx'];
    defaultCountry = json['DefaultCountry'];
    dltNo = json['DltNo'];
    aruthKey = json['AruthKey'];
    apiUrl = json['ApiUrl'];
    wabaNo = json['WabaNo'];
    wabaId = json['WabaId'];
    hsmId = json['HsmId'];
    hsmPwd = json['HsmPwd'];
    providerName = json['ProviderName'];
    wabaMobileNumber = json['WabaMobileNumber'];
    agentId = json['AgentId'];
    agentMobile = json['AgentMobile'];
    profileImagePath = json['ProfileImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = userName;
    data['WabaBalance'] = wabaBalance;
    data['UserType'] = userType;
    data['SmsBal'] = smsBal;
    data['UrlBalance'] = urlBalance;
    data['NoOfhit'] = noOfhit;
    data['UrlRate'] = urlRate;
    data['DltCharge'] = dltCharge;
    data['RateNormalSms'] = rateNormalSms;
    data['RateSmartSms'] = rateSmartSms;
    data['RateCampaign'] = rateCampaign;
    data['RateOtp'] = rateOtp;
    data['Email'] = email;
    data['CCEmail'] = cCEmail;
    data['Mobile'] = mobile;
    data['DomainName'] = domainName;
    data['ShowSmsDLR'] = showSmsDLR;
    data['ShowMobilexxxx'] = showMobilexxxx;
    data['DefaultCountry'] = defaultCountry;
    data['DltNo'] = dltNo;
    data['AruthKey'] = aruthKey;
    data['ApiUrl'] = apiUrl;
    data['WabaNo'] = wabaNo;
    data['WabaId'] = wabaId;
    data['HsmId'] = hsmId;
    data['HsmPwd'] = hsmPwd;
    data['ProviderName'] = providerName;
    data['WabaMobileNumber'] = wabaMobileNumber;
    data['AgentId'] = agentId;
    data['AgentMobile'] = agentMobile;
    data['ProfileImagePath'] = profileImagePath;
    return data;
  }
}