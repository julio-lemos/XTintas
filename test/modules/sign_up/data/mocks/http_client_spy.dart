import 'package:mocktail/mocktail.dart';
import 'package:xtintas/infra/http/http.dart';

class HttpClientSpy extends Mock implements IHttpClient {
  When mockRequestCall() => when(() => post(any(), body: any(named: "body")));

  void mockSuccess(Map<String, dynamic> data) =>
      mockRequestCall().thenAnswer((_) async => data);
  void mockFail(HttpError errorCode) => mockRequestCall().thenThrow(errorCode);
}
