import '../../../store/domain/entities/entities.dart';
import '../entities/entities.dart';

abstract class ICartUseCases {
  Future<List<PaintCartEntity>> getCart();

  Future<void> addInCart(InkEntity entity);

  Future<void> deleteInCart(int id);
}
