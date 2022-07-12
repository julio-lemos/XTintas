import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/infra/http/http_client.dart';
import 'package:xtintas/modules/profile/adapters/adapters.dart';
import 'package:xtintas/modules/profile/data/usecases/remote_profile_usecase.dart';
import 'package:xtintas/presenter/page/profile.page.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<ProfileAdapters>((i) => ProfileAdapters()),
        Bind.factory(
          (i) => RemoteProfileUseCase(
              httpClient: Modular.get<IHttpClient>(),
              adapter: i<ProfileAdapters>()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => const ProfilePage(),
          transition: TransitionType.leftToRightWithFade,
        )
      ];
}
