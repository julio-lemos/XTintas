abstract class IHttpClient {
  Future<dynamic> get(String url);

  Future<dynamic> post(String url, {required Map<String, dynamic> body});
}
