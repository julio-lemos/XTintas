import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xtintas/infra/http/http.dart';
import 'package:xtintas/modules/store/adapters/store.adapters.dart';
import 'package:xtintas/modules/store/data/errors/erros.dart';
import 'package:xtintas/modules/store/data/usecases/usecases.dart';

import '../../mocks/http_client_spy.dart';

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late StoreAdapters adapter;
  late RemoteStoreUseCases sut;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    adapter = StoreAdapters();
    httpClient.mockSuccess();
    sut =
        RemoteStoreUseCases(httpClient: httpClient, url: url, adapter: adapter);
  });

  test('deve retornar um elemento corretamente', () async {
    final result = await sut.getPaints();

    result.fold((l) => null, (r) {
      expect(r.count, 3);
      expect(r.paints[2].name, "Tinta Suvinil Limpeza Total");
    });
  });

  test('deve retornar o erro correto', () async {
    httpClient.mockFail(HttpError.unexpected);

    final result = await sut.getPaints();

    expect(result.fold(id, id), isA<UnexpectedError>());
  });
}
