import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/models/http_bin.dart';
import 'package:flutter_in_action_source_code/routes/future_builder_route.dart';
import 'package:flutter_in_action_source_code/widgets/index.dart';

class DioTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DioTestRoute();
}

class _DioTestRoute extends State<DioTestRoute> {
  Dio _dio = Dio();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                _getRequestAction();
              },
              child: Text("Get请求")),
          ElevatedButton(
              onPressed: () {
                _getRequestAction(needParam: true);
              },
              child: Text("Get请求(追加参数)")),
          ElevatedButton(
              onPressed: () {
                _postRequestAction();
              },
              child: Text("Post请求")),
          ElevatedButton(
              onPressed: () {
                _postRequestAction(isFormData: true);
              },
              child: Text("Post请求(form)")),
          ElevatedButton(
              onPressed: () {
                _mutiRequestAction();
              },
              child: Text("并发多请求")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return PageScaffold(
                      "Dio请求Github接口样例", FutureBuilderRoute(), true);
                }));
              },
              child: Text("Dio请求Github接口样例")),
        ],
      ),
    );
  }

  void _postRequestAction({bool isFormData = false}) async {
    Object data = {"key": "value"};
    if (isFormData) {
      data = FormData.fromMap({
        "name": "wendux",
        "age": 25,
      });
    }
    try {
      Response response = await _dio.post("https://httpbin.org/post",
          data: data,
          options: Options(
              headers: {"User-Agent": "test"},
              responseType: ResponseType.json));
      var content = response.data.toString().split(",").join(",\n");
      _showResponse(content);
    } catch (e) {
      print(e);
      _showResponse(e.toString());
    }
  }

  void _getRequestAction({bool needParam = false}) async {
    Map<String, String>? queryParameters;
    if (needParam) {
      queryParameters = {"key": "value"};
    }
    Response response = await _dio.get("https://httpbin.org/get",
        queryParameters: queryParameters,
        options: Options(
            headers: {"User-Agent": "test"}, responseType: ResponseType.json));
    HttpBin httpBin = HttpBin.fromJson(response.data);
    print(httpBin.headers!.userAgent!);
    var content = response.data.toString().split(",").join(",\n");
    _showResponse(content);
  }

  void _mutiRequestAction() async {
    var response = (await Future.wait([
      _dio.get("https://httpbin.org/get",
          options: Options(
              headers: {"User-Agent": "test"},
              responseType: ResponseType.json)),
      _dio.post("https://httpbin.org/post",
          options: Options(
              headers: {"User-Agent": "test"}, responseType: ResponseType.json))
    ]));
    var content = response.first.data.toString().split(",").join(",\n") +
        "\n\n" +
        response.last.data.toString().split(",").join(",\n");
    _showResponse(content);
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
