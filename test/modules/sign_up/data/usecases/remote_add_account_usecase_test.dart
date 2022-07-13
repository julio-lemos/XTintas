import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xtintas/infra/http/http.dart';
import 'package:xtintas/modules/sign_up/data/errors/errors.dart';
import 'package:xtintas/modules/sign_up/data/usecases/usecases.dart';
import 'package:xtintas/modules/sign_up/domain/usecases/usecases.dart';

import '../mocks/http_client_spy.dart';

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late AddAccountParams params;
  late RemoteAddAccountUseCase sut;

  setUp(() {
    httpClient = HttpClientSpy();
    params = AddAccountParams(
        name: "Robisvaldo Azevedo",
        email: "robinho@azevedo.com",
        password: "123456",
        repeatPassword: "123456");
    url = faker.internet.httpUrl();
    httpClient.mockSuccess({
      "name": "teste",
      "email": "teste@gmail.com",
      "password": "123456",
      "id": "9"
    });
    sut = RemoteAddAccountUseCase(httpClient: httpClient);
  });

  test("should call httpClient with correct values", () async {
    await sut.createAccount(params);

    verify(() => httpClient.post(url, body: {
          "name": "Robisvaldo Azevedo",
          "email": "robinho@azevedo.com",
          "password": "123456",
        })).called(1);
  });

  test("should return the correct type in case of error", () async {
    httpClient.mockFail(HttpError.unexpected);

    final result = await sut.createAccount(params);

    expect(result.fold(id, id), isA<UnexpectedError>());
  });

  test("should return the correct type in case of divergent passwords",
      () async {
    final result = await sut.createAccount(AddAccountParams(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
        repeatPassword: faker.internet.password()));

    expect(result.fold(id, id), isA<DivergentsPasswords>());
  });
}
