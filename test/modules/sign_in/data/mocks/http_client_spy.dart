import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xtintas/infra/http/http.dart';

class HttpClientSpy extends Mock implements IHttpClient {
  When mockRequestCall() => when(() => get(any()));

  void mockSuccess() => mockRequestCall()
      .thenAnswer((_) async => {"access_token": faker.guid.random.toString()});
  void mockFail(HttpError errorCode) => mockRequestCall().thenThrow(errorCode);
}
