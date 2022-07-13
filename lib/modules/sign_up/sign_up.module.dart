import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/infra/http/http_client.dart';

import '../../presenter/page/page.dart';
import 'data/usecases/usecases.dart';
import 'domain/usecases/usecases.dart';

class SignUpModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<IAddAccountUseCase>(
            (i) => RemoteAddAccountUseCase(httpClient: Modular.get<IHttpClient>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => SignUpPage(),
          transition: TransitionType.leftToRightWithFade,
        )
      ];
}
