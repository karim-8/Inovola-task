import 'package:dio/dio.dart';

class HttpClient {
  static Dio _dio;

  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions baseOptions =
          new BaseOptions(baseUrl: "https://run.mocky.io/");
      _dio = new Dio(baseOptions);
      _dio.interceptors.add(LogInterceptor());
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("${options.data.toString()}");
        print("${options.headers.toString()}");

        // Do something before request is sent
        return options; //continue
      }, onResponse: (Response response) {
        // Do something with response data

        print("${response.statusCode}");

        print("${response.data.toString()}");

        return response; // continue
      }, onError: (DioError e) {
        print("${e.response.statusCode}");
        print("${e.response.data.toString()}");

        if (e.response.statusCode == 401) {
          throw ("Un Authorized Access ${e.response.data}");
        } else if (e.response.statusCode == 403) {
          throw ("Loging Out ${e.response.data}");
        } else if (e.response.statusCode == 500) {
          throw ("Server Error ${e.response.data}");
        }
        return e; //continue
      }));
    }

    return _dio;
  }
}
