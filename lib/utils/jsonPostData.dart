// ignore_for_file: file_names

class RequestUtils {

  Map getAuthToken({
    required userName,
    required passWord,
  }) {
    Map jsonPostData = {
      "username": userName,
      "password": passWord
    };
    return jsonPostData;
  }

  Map getLoginDetail({
    required userName,
    required passWord,
  }) {
    Map  jsonPostData = {
      "username": userName,
      "password": passWord
    };
    return jsonPostData;
  }

  Map getSendSchedule({
    required countrycode,
    required whatsappType,
    required campaignName,
    required xLUPLOADED,
    required uPLOADFILENM,
    required group,
    required dTXLDistinct,
    required totalgroupMember,
    required mobileList,
    required allowDuplicate,
    required duplicate,
    required notDuplicate,
    required mobileCount,
    required manual,
    required templateId,
    required cbFailover,
    required fileOrUrl,
    required mediaUName,
    required fileUrl,
    required caption,
    required msgText,
    required locnameid,
    required headerType,
    required lstMappedField,
    required senderId,
    required chkOptOut,
    required optOut,
    required lstTemplateFld,
    required lstScheduleDate,
    required mediaFileName,
    required mediaUrl,
    required scratchCard,
    required totCount,
    required preview,
    required textBox1,
    required textBox2,
    required textBox3,
    required textBox4,
    required textBox5,
    required textBox6,
    required textBox7,
    required textBox8,
    required textBox9,
    required textBox10,
  }) {
    Map  jsonPostData = {
      "Countrycode": countrycode,
      "WhatsappType": whatsappType,
      "CampaignName": campaignName,
      "XLUPLOADED": xLUPLOADED,
      "UPLOADFILENM": uPLOADFILENM,
      "group": group,
      "DTXLDistinct": dTXLDistinct,
      "TotalgroupMember": totalgroupMember,
      "MobileList": mobileList,
      "AllowDuplicate": allowDuplicate,
      "Duplicate": duplicate,
      "NotDuplicate": notDuplicate,
      "MobileCount": mobileCount,
      "Manual": manual,
      "TemplateId": templateId,
      "CbFailover": cbFailover,
      "FileOrUrl": fileOrUrl,
      "MediaUName": mediaUName,
      "FileUrl": fileUrl,
      "Caption": caption,
      "MsgText": msgText,
      "Locnameid": locnameid,
      "HeaderType": headerType,
      "lstMappedField": lstMappedField,
      "SenderId": senderId,
      "chkOptOut": chkOptOut,
      "OptOut": optOut,
      "lstTemplateFld": lstTemplateFld,
      "lstScheduleDate": lstScheduleDate,
      "MediaFileName": mediaFileName,
      "MediaUrl": mediaUrl,
      "ScratchCard": scratchCard,
      "TotCount": totCount,
      "Preview": preview,
      "TextBox1": textBox1,
      "TextBox2": textBox2,
      "TextBox3": textBox3,
      "TextBox4": textBox4,
      "TextBox5": textBox5,
      "TextBox6": textBox6,
      "TextBox7": textBox7,
      "TextBox8": textBox8,
      "TextBox9": textBox9,
      "TextBox10": textBox10,
    };
    return jsonPostData;
  }
}