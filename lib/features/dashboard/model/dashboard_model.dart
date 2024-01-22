class DashboardModel {
  int? statusCode;
  String? error;
  DashboardModelSuccess? data;

  DashboardModel({this.statusCode, this.data, this.error});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    data = json['data'] != null ? DashboardModelSuccess.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (count != null) {
      data['Count'] = count!.toJson();
    }
    if (chart != null) {
      data['Chart'] = chart!.map((v) => v.toJson()).toList();
    }
    return data;
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
  double? seenPercent;

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