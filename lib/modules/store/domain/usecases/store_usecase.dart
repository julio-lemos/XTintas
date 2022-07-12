import 'package:dartz/dartz.dart';
import 'package:xtintas/modules/store/domain/entities/store_entity.dart';

import '../../data/errors/erros.dart';

abstract class IStoreUseCase {
  Future<Either<IStoreException, StoreEntity>> getPaints();
}
