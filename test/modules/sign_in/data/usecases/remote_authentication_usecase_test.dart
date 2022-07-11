import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xtintas/infra/http/http.dart';
import 'package:xtintas/modules/sign_in/data/errors/signin.errors.dart';
import 'package:xtintas/modules/sign_in/data/usecases/usecases.dart';
import 'package:xtintas/modules/sign_in/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../mocks/http_client_spy.dart';

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late AuthParams params;
  late RemoteAuthenticationUseCase sut;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    params = AuthParams(
        email: faker.internet.email(), password: faker.internet.password());
    httpClient.mockSuccess();
    sut = RemoteAuthenticationUseCase(httpClient: httpClient, url: url);
  });

  test("should call httpClient with correct values", () async {
    await sut.auth(params);

    verify(() => httpClient.get(url)).called(1);
  });

  test("should return the correct type in case of error", () async {
    httpClient.mockFail(HttpError.unexpected);

    final result = await sut.auth(params);

    expect(result.fold(id, id), isA<UnexpectedError>());
  });
}
