import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HttpClientTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HttpClientTestRouteState();
}

class _HttpClientTestRouteState extends State<HttpClientTestRoute> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => _getRequestAction(), child: Text("Get请求")),
          ElevatedButton(
              onPressed: () => _getRequestAction(needParam: true),
              child: Text("Get请求(追加参数)")),
          ElevatedButton(
              onPressed: () => _postRequestAction(), child: Text("Post请求")),
          ElevatedButton(
              onPressed: () => _postRequestAction(isFormData: true),
              child: Text("Post请求(form)")),
        ],
      ),
    );
  }

  void _postRequestAction({bool isFormData = false}) async {
    var httpClient = HttpClient();
    var uri = Uri(
        scheme: "https",
        host: "httpbin.org",
        path: "post",
        queryParameters: {"key": "value"});
    var request = await httpClient.postUrl(uri);
    request.headers.add("user-agent", "test_post");
    if (isFormData) {
      request.headers.add("Content-type", "application/x-www-form-urlencoded");
      var formData = utf8.encode("key2=value2&key3=value3");
      request.add(formData);
    } else {
      var requestData = utf8.encode(json.encode({"key1": "value1"}));
      request.add(requestData);
    }
    var responseData = await request.close();
    var content = await responseData.transform(utf8.decoder).join();
    httpClient.close();
    _showResponse(content);
  }

  void _getRequestAction({bool needParam = false}) async {
    HttpClient httpClient = HttpClient();
    Map<String, String>? queryParameters;
    if (needParam) {
      queryParameters = {"key": "value"};
    }
    var uri = Uri(
        scheme: "https",
        host: "httpbin.org",
        path: "get",
        queryParameters: queryParameters);
    var request = await httpClient.getUrl(uri);
    request.headers.add("user-agent", "test_get");
    HttpClientResponse responseData = await request.close();
    var content = await responseData.transform(utf8.decoder).join();
    httpClient.close();
    var data = jsonDecode(content);
    var string = data.toString().split(",").join(",\n");
    print(data);
    _showResponse(string);
  }

  void _showResponse(String data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("response"),
            content: Text(data),
          );
        });
  }
}
