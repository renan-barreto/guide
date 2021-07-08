class FinancesModel {
  Chart? chart;

  FinancesModel({this.chart});

  FinancesModel.fromJson(Map<String, dynamic> json) {
    chart = json['chart'] != null ? new Chart.fromJson(json['chart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chart != null) {
      data['chart'] = this.chart!.toJson();
    }
    return data;
  }
}

class Chart {
  List<Result>? result;
  dynamic error;

  Chart({this.result, this.error});

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Result {
  Meta? meta;
  List<int>? timestamp;
  Indicators? indicators;

  Result({this.meta, this.timestamp, this.indicators});

  Result.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    timestamp = json['timestamp'].cast<int>();
    indicators = json['indicators'] != null
        ? new Indicators.fromJson(json['indicators'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['timestamp'] = this.timestamp;
    if (this.indicators != null) {
      data['indicators'] = this.indicators!.toJson();
    }
    return data;
  }
}

class Meta {
  String? currency;
  String? symbol;
  String? exchangeName;
  String? instrumentType;
  int? firstTradeDate;
  int? regularMarketTime;
  int? gmtoffset;
  String? timezone;
  String? exchangeTimezoneName;
  double? regularMarketPrice;
  double? chartPreviousClose;
  double? previousClose;
  int? scale;
  int? priceHint;
  CurrentTradingPeriod? currentTradingPeriod;
  String? dataGranularity;
  String? range;
  List<String>? validRanges;

  Meta(
      {this.currency,
      this.symbol,
      this.exchangeName,
      this.instrumentType,
      this.firstTradeDate,
      this.regularMarketTime,
      this.gmtoffset,
      this.timezone,
      this.exchangeTimezoneName,
      this.regularMarketPrice,
      this.chartPreviousClose,
      this.previousClose,
      this.scale,
      this.priceHint,
      this.currentTradingPeriod,
      this.dataGranularity,
      this.range,
      this.validRanges});

  Meta.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    symbol = json['symbol'];
    exchangeName = json['exchangeName'];
    instrumentType = json['instrumentType'];
    firstTradeDate = json['firstTradeDate'];
    regularMarketTime = json['regularMarketTime'];
    gmtoffset = json['gmtoffset'];
    timezone = json['timezone'];
    exchangeTimezoneName = json['exchangeTimezoneName'];
    regularMarketPrice = json['regularMarketPrice'];
    chartPreviousClose = json['chartPreviousClose'];
    previousClose = json['previousClose'];
    scale = json['scale'];
    priceHint = json['priceHint'];
    currentTradingPeriod = json['currentTradingPeriod'] != null
        ? new CurrentTradingPeriod.fromJson(json['currentTradingPeriod'])
        : null;
    dataGranularity = json['dataGranularity'];
    range = json['range'];
    validRanges = json['validRanges'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['symbol'] = this.symbol;
    data['exchangeName'] = this.exchangeName;
    data['instrumentType'] = this.instrumentType;
    data['firstTradeDate'] = this.firstTradeDate;
    data['regularMarketTime'] = this.regularMarketTime;
    data['gmtoffset'] = this.gmtoffset;
    data['timezone'] = this.timezone;
    data['exchangeTimezoneName'] = this.exchangeTimezoneName;
    data['regularMarketPrice'] = this.regularMarketPrice;
    data['chartPreviousClose'] = this.chartPreviousClose;
    data['previousClose'] = this.previousClose;
    data['scale'] = this.scale;
    data['priceHint'] = this.priceHint;
    if (this.currentTradingPeriod != null) {
      data['currentTradingPeriod'] = this.currentTradingPeriod!.toJson();
    }
    data['dataGranularity'] = this.dataGranularity;
    data['range'] = this.range;
    data['validRanges'] = this.validRanges;
    return data;
  }
}

class CurrentTradingPeriod {
  Pre? pre;
  Pre? regular;
  Pre? post;

  CurrentTradingPeriod({this.pre, this.regular, this.post});

  CurrentTradingPeriod.fromJson(Map<String, dynamic> json) {
    pre = json['pre'] != null ? new Pre.fromJson(json['pre']) : null;
    regular =
        json['regular'] != null ? new Pre.fromJson(json['regular']) : null;
    post = json['post'] != null ? new Pre.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pre != null) {
      data['pre'] = this.pre!.toJson();
    }
    if (this.regular != null) {
      data['regular'] = this.regular!.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    return data;
  }
}

class Pre {
  String? timezone;
  int? start;
  int? end;
  int? gmtoffset;

  Pre({this.timezone, this.start, this.end, this.gmtoffset});

  Pre.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    start = json['start'];
    end = json['end'];
    gmtoffset = json['gmtoffset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    data['start'] = this.start;
    data['end'] = this.end;
    data['gmtoffset'] = this.gmtoffset;
    return data;
  }
}

class Indicators {
  List<Quote>? quote;

  Indicators({this.quote});

  Indicators.fromJson(Map<String, dynamic> json) {
    if (json['quote'] != null) {
      quote = <Quote>[];
      json['quote'].forEach((v) {
        quote!.add(new Quote.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quote != null) {
      data['quote'] = this.quote!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quote {
  List<double>? low;
  List<double>? close;
  List<double>? open;
  List<int>? volume;
  List<double>? high;

  Quote({this.low, this.close, this.open, this.volume, this.high});

  Quote.fromJson(Map<String, dynamic> json) {
    low = json['low'].cast<double>();
    close = json['close'].cast<double>();
    open = json['open'].cast<double>();
    volume = json['volume'].cast<int>();
    high = json['high'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['low'] = this.low;
    data['close'] = this.close;
    data['open'] = this.open;
    data['volume'] = this.volume;
    data['high'] = this.high;
    return data;
  }
}
