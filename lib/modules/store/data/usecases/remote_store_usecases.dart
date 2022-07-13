import 'package:xtintas/modules/store/adapters/store.adapters.dart';
import 'package:xtintas/modules/store/data/errors/store_errors.dart';

import 'package:dartz/dartz.dart';

import '../../../../infra/http/http.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class RemoteStoreUseCases implements IStoreUseCase {
  final IHttpClient httpClient;
  final StoreAdapters adapter;

  RemoteStoreUseCases({
    required this.httpClient,
    required this.adapter,
  });

  @override
  Future<Either<IStoreException, StoreEntity>> getPaints() async {
    try {
      final response = await httpClient.get("https://62968cc557b625860610144c.mockapi.io/paints");

      return right(adapter.fromMap(response));
    } on HttpError catch (err, stackTrace) {
      return left(UnexpectedError(
          "Um erro aconteceu ao exibir as tintas. Tente novamente mais tarde.", stackTrace));
    }
  }
}
