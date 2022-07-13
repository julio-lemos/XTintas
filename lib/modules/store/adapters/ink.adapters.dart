import 'package:xtintas/modules/store/domain/entities/ink_entity.dart';

class InkAdapter {
  Map<String, dynamic> toMap(InkEntity entity) {
    return {
      "name": entity.name,
      "image": entity.imgUrl,
      "price": entity.price,
      "benefits": entity.benefits
    };
  }
}
