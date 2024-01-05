class IndividualChatModel {
  String? statusCode;
  String? error;
  Data? data;

  IndividualChatModel({this.statusCode, this.data});

  IndividualChatModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? messageTitle;
  List<Conversation>? conversation;
  Customer? customer;
  List<Agent>? agent;
  List<ConversationHistory>? conversationHistory;

  Data(
      {this.messageTitle,
        this.conversation,
        this.customer,
        this.agent,
        this.conversationHistory});

  Data.fromJson(Map<String, dynamic> json) {
    messageTitle = json['Message_title'];
    if (json['Conversation'] != null) {
      conversation = <Conversation>[];
      json['Conversation'].forEach((v) {
        conversation!.add(Conversation.fromJson(v));
      });
    }
    customer = json['Customer'] != null
        ? Customer.fromJson(json['Customer'])
        : null;
    if (json['Agent'] != null) {
      agent = <Agent>[];
      json['Agent'].forEach((v) {
        agent!.add(Agent.fromJson(v));
      });
    }
    if (json['ConversationHistory'] != null) {
      conversationHistory = <ConversationHistory>[];
      json['ConversationHistory'].forEach((v) {
        conversationHistory!.add(ConversationHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Message_title'] = messageTitle;
    if (conversation != null) {
      data['Conversation'] = conversation!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['Customer'] = customer!.toJson();
    }
    if (agent != null) {
      data['Agent'] = agent!.map((v) => v.toJson()).toList();
    }
    if (conversationHistory != null) {
      data['ConversationHistory'] =
          conversationHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversation {
  String? serialNo;
  String? msgtext;
  String? inserttime;
  String? sentfrom;
  String? fromMob;
  String? filePath;
  String? fileName;
  String? datePrint;
  String? latitude;
  String? longitude;

  Conversation(
      {this.serialNo,
        this.msgtext,
        this.inserttime,
        this.sentfrom,
        this.fromMob,
        this.filePath,
        this.fileName,
        this.datePrint,
        this.latitude,
        this.longitude});

  Conversation.fromJson(Map<String, dynamic> json) {
    serialNo = json['SerialNo'];
    msgtext = json['msgtext'];
    inserttime = json['inserttime'];
    sentfrom = json['sentfrom'];
    fromMob = json['fromMob'];
    filePath = json['FilePath'];
    fileName = json['FileName'];
    datePrint = json['DatePrint'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['SerialNo'] = serialNo;
    data['msgtext'] = msgtext;
    data['inserttime'] = inserttime;
    data['sentfrom'] = sentfrom;
    data['fromMob'] = fromMob;
    data['FilePath'] = filePath;
    data['FileName'] = fileName;
    data['DatePrint'] = datePrint;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Customer {
  String? mobileNumber;
  String? name;
  String? areaIdentifierId;
  String? propertyType;
  String? email;
  String? address;
  String? inserttime;
  String? wabaMobileNumber;

  Customer(
      {this.mobileNumber,
        this.name,
        this.areaIdentifierId,
        this.propertyType,
        this.email,
        this.address,
        this.inserttime,
        this.wabaMobileNumber});

  Customer.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['MobileNumber'];
    name = json['Name'];
    areaIdentifierId = json['AreaIdentifierId'];
    propertyType = json['PropertyType'];
    email = json['Email'];
    address = json['address'];
    inserttime = json['inserttime'];
    wabaMobileNumber = json['WabaMobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['MobileNumber'] = mobileNumber;
    data['Name'] = name;
    data['AreaIdentifierId'] = areaIdentifierId;
    data['PropertyType'] = propertyType;
    data['Email'] = email;
    data['address'] = address;
    data['inserttime'] = inserttime;
    data['WabaMobileNumber'] = wabaMobileNumber;
    return data;
  }
}

class Agent {
  String? agent;
  String? agentId;

  Agent({this.agent, this.agentId});

  Agent.fromJson(Map<String, dynamic> json) {
    agent = json['Agent'];
    agentId = json['AgentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Agent'] = agent;
    data['AgentId'] = agentId;
    return data;
  }
}

class ConversationHistory {
  String? lastMessageAt2;

  ConversationHistory({this.lastMessageAt2});

  ConversationHistory.fromJson(Map<String, dynamic> json) {
    lastMessageAt2 = json['LastMessageAt2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['LastMessageAt2'] = lastMessageAt2;
    return data;
  }
}