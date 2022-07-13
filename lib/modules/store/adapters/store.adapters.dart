import '../domain/entities/entities.dart';

class StoreAdapters {
  StoreEntity fromMap(Map<String, dynamic> map) {
    return StoreEntity(
        count: map["count"],
        paints: (map["data"] as List<dynamic>)
            .map((e) => InkEntity(
                name: e["name"], imgUrl: e["image"], price: e["price"], benefits: e["benefits"]))
            .toList());
  }
}
