// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:xtintas/infra/http/http_client.dart';
import 'package:xtintas/modules/cart/adapters/paint_cart_adapter.dart';
import 'package:xtintas/modules/cart/domain/entities/paint_cart_entity.dart';
import 'package:xtintas/modules/store/adapters/ink.adapters.dart';
import 'package:xtintas/modules/store/domain/entities/ink_entity.dart';

import '../domain/usecases/cart_usecase.dart';

class RemoteCartUseCase implements ICartUseCases {
  final IHttpClient httpClient;
  final InkAdapter inkAdapter;
  final PaintCartAdapter paintAdapter;

  RemoteCartUseCase(
      {required this.httpClient, required this.inkAdapter, required this.paintAdapter});

  @override
  Future<List<PaintCartEntity>> getCart() async {
    final response = await httpClient.get("https://62968cc557b625860610144c.mockapi.io/cart");

    return (response as List<dynamic>).map((e) => paintAdapter.fromMap(e)).toList();
  }

  @override
  Future<void> addInCart(InkEntity entity) async {
    await httpClient.post("https://62968cc557b625860610144c.mockapi.io/cart",
        body: inkAdapter.toMap(entity));
  }

  @override
  Future<void> deleteInCart(int id) async {
    await httpClient.delete(
      "https://62968cc557b625860610144c.mockapi.io/cart/${id}",
    );
  }
}
