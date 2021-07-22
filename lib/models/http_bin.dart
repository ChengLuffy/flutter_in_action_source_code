/// args : {"key":"value"}
/// headers : {"Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8","Accept-Encoding":"gzip, deflate, br","Accept-Language":"zh-cn","Host":"httpbin.org","User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15","X-Amzn-Trace-Id":"Root=1-60ecfa9f-41f005cc35be8a0b5ec80723"}
/// origin : "104.224.191.91"
/// url : "https://httpbin.org/get?key=value"

/// 使用插件 JsonToDart 生成

class HttpBin {
  Map? _args;
  Headers? _headers;
  String? _origin;
  String? _url;

  Map? get args => _args;
  Headers? get headers => _headers;
  String? get origin => _origin;
  String? get url => _url;

  HttpBin({Map? args, Headers? headers, String? origin, String? url}) {
    _args = args;
    _headers = headers;
    _origin = origin;
    _url = url;
  }

  HttpBin.fromJson(dynamic json) {
    _args = json["args"] != null ? json["args"] : null;
    _headers =
        json["headers"] != null ? Headers.fromJson(json["headers"]) : null;
    _origin = json["origin"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_args != null) {
      map["args"] = _args;
    }
    if (_headers != null) {
      map["headers"] = _headers?.toJson();
    }
    map["origin"] = _origin;
    map["url"] = _url;
    return map;
  }
}

/// Accept : "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
/// Accept-Encoding : "gzip, deflate, br"
/// Accept-Language : "zh-cn"
/// Host : "httpbin.org"
/// User-Agent : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15"
/// X-Amzn-Trace-Id : "Root=1-60ecfa9f-41f005cc35be8a0b5ec80723"

class Headers {
  String? _accept;
  String? _acceptEncoding;
  String? _acceptLanguage;
  String? _host;
  String? _userAgent;
  String? _xAmznTraceId;

  String? get accept => _accept;
  String? get acceptEncoding => _acceptEncoding;
  String? get acceptLanguage => _acceptLanguage;
  String? get host => _host;
  String? get userAgent => _userAgent;
  String? get xAmznTraceId => _xAmznTraceId;

  Headers(
      {String? accept,
      String? acceptEncoding,
      String? acceptLanguage,
      String? host,
      String? userAgent,
      String? xAmznTraceId}) {
    _accept = accept;
    _acceptEncoding = acceptEncoding;
    _acceptLanguage = acceptLanguage;
    _host = host;
    _userAgent = userAgent;
    _xAmznTraceId = xAmznTraceId;
  }

  Headers.fromJson(dynamic json) {
    _accept = json["Accept"];
    _acceptEncoding = json["Accept-Encoding"];
    _acceptLanguage = json["Accept-Language"];
    _host = json["Host"];
    _userAgent = json["User-Agent"];
    _xAmznTraceId = json["X-Amzn-Trace-Id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Accept"] = _accept;
    map["Accept-Encoding"] = _acceptEncoding;
    map["Accept-Language"] = _acceptLanguage;
    map["Host"] = _host;
    map["User-Agent"] = _userAgent;
    map["X-Amzn-Trace-Id"] = _xAmznTraceId;
    return map;
  }
}
