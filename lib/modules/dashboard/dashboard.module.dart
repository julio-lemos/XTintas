import 'package:flutter_modular/flutter_modular.dart';

import '../../presenter/page/dashboard.page.dart';
import '../profile/profile.module.dart';
import '../store/store.module.dart';

class DashboardModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => const DashboardPage(),
          children: [
            ModuleRoute("/store", module: StoreModule()),
            ModuleRoute("/profile", module: ProfileModule()),
          ],
          transition: TransitionType.leftToRightWithFade,
        )
      ];
}
