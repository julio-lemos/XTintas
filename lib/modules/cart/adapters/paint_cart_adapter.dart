import 'package:xtintas/modules/cart/domain/entities/entities.dart';

class PaintCartAdapter {
  PaintCartEntity fromMap(Map<String, dynamic> map) {
    return PaintCartEntity(
        id: map["id"],
        name: map["name"],
        image: map["image"],
        price: map["price"],
        paint: map["paint"],
        quantity: map["quantity"],
        benefits: map["benefits"]);
  }
}
