import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/infra/http/http.dart';

abstract class IHttpClient {
  Future<dynamic> get(String url);

  Future<dynamic> post(String url, {required Map<String, dynamic> body});
}

class HttpClient implements IHttpClient {
  @override
  Future get(String url) async {
    Response response;

    try {
      response = await Modular.get<Dio>().get(url);
    } catch (err) {
      throw HttpError.unexpected;
    }

    return _handleResponse(response);
  }

  @override
  Future post(String url, {required Map<String, dynamic> body}) async {
    Response response;

    try {
      response = await Modular.get<Dio>().post(url, data: body);
    } catch (err) {
      throw HttpError.unexpected;
    }

    return _handleResponse(response);
  }
}

_handleResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      return response.data;
    case 401:
      throw HttpError.unauthorized;
    default:
      throw HttpError.unexpected;
  }
}
