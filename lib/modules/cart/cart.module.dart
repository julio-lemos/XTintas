import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/modules/cart/adapters/paint_cart_adapter.dart';
import 'package:xtintas/modules/cart/data/remote_cart_usecases.dart';
import 'package:xtintas/modules/cart/domain/usecases/cart_usecase.dart';
import 'package:xtintas/modules/store/adapters/ink.adapters.dart';

import '../../infra/http/http_client.dart';
import '../../presenter/page/cart.page.dart';

class CartModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<InkAdapter>((i) => InkAdapter()),
        Bind.factory<PaintCartAdapter>((i) => PaintCartAdapter()),
        Bind.factory<ICartUseCases>(
          (i) => RemoteCartUseCase(
            httpClient: i<IHttpClient>(),
            inkAdapter: i<InkAdapter>(),
            paintAdapter: i<PaintCartAdapter>(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => const CartPage(),
          transition: TransitionType.leftToRightWithFade,
        ),
      ];
}
