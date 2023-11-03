class DashboardModel {
  int? statusCode;
  DashboardModelSuccess? data;

  DashboardModel({this.statusCode, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? DashboardModelSuccess.fromJson(json['data']) : null;
  }
}

class DashboardModelSuccess {
  Count? count;
  List<Chart>? chart;

  DashboardModelSuccess({this.count, this.chart});

  DashboardModelSuccess.fromJson(Map<String, dynamic> json) {
    count = json['Count'] != null ? Count.fromJson(json['Count']) : null;
    if (json['Chart'] != null) {
      chart = <Chart>[];
      json['Chart'].forEach((v) {
        chart!.add(Chart.fromJson(v));
      });
    }
  }
}

class Count {
  int? totalCount;
  int? opened;
  int? closed;
  int? pending;
  int? average;
  int? sUBMITTED;
  int? dELIVERED;
  int? fAILED;
  int? sEEN;
  int? seenPercent;

  Count(
      {this.totalCount,
      this.opened,
      this.closed,
      this.pending,
      this.average,
      this.sUBMITTED,
      this.dELIVERED,
      this.fAILED,
      this.sEEN,
      this.seenPercent});

  Count.fromJson(Map<String, dynamic> json) {
    totalCount = json['TotalCount'];
    opened = json['opened'];
    closed = json['closed'];
    pending = json['Pending'];
    average = json['Average'];
    sUBMITTED = json['SUBMITTED'];
    dELIVERED = json['DELIVERED'];
    fAILED = json['FAILED'];
    sEEN = json['SEEN'];
    seenPercent = json['SeenPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalCount'] = totalCount;
    data['opened'] = opened;
    data['closed'] = closed;
    data['Pending'] = pending;
    data['Average'] = average;
    data['SUBMITTED'] = sUBMITTED;
    data['DELIVERED'] = dELIVERED;
    data['FAILED'] = fAILED;
    data['SEEN'] = sEEN;
    data['SeenPercent'] = seenPercent;
    return data;
  }
}

class Chart {
  String? day;
  int? countOfRecords;

  Chart({this.day, this.countOfRecords});

  Chart.fromJson(Map<String, dynamic> json) {
    day = json['Day'];
    countOfRecords = json['CountOfRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Day'] = day;
    data['CountOfRecords'] = countOfRecords;
    return data;
  }
}