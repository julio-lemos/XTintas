import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/infra/http/http_client.dart';
import 'package:xtintas/presenter/page/sign_in.page.dart';

import 'data/usecases/usecases.dart';
import 'domain/usecases/usecases.dart';

class SignInModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<IAuthenticationUseCase>((i) =>
            RemoteAuthenticationUseCase(httpClient: Modular.get<IHttpClient>()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => SignInPage(),
          transition: TransitionType.leftToRightWithFade,
        )
      ];
}
