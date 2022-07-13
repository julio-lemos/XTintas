import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/infra/http/http_client.dart';
import 'package:xtintas/modules/store/adapters/adapters.dart';
import 'package:xtintas/modules/store/data/usecases/usecases.dart';
import 'package:xtintas/modules/store/domain/usecases/store_usecase.dart';
import 'package:xtintas/presenter/page/how_paint.page.dart';
import 'package:xtintas/presenter/page/store.page.dart';

class StoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<StoreAdapters>((i) => StoreAdapters()),
        Bind.factory<IStoreUseCase>((i) => RemoteStoreUseCases(
            httpClient: Modular.get<IHttpClient>(), adapter: i<StoreAdapters>()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => const StorePage(),
          transition: TransitionType.leftToRightWithFade,
        ),
        ChildRoute("/how_paint", child: (context, args) => const HowPaint())
      ];
}
