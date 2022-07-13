// coverage:ignore-file
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/infra/http/http_client.dart';
import 'package:xtintas/modules/dashboard/dashboard.module.dart';
import 'package:xtintas/modules/sign_in/sign_in.module.dart';
import 'package:xtintas/modules/store/store.module.dart';

import 'sign_up/sign_up.module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds =>
      [Bind.singleton<Dio>((i) => Dio()), Bind.singleton<IHttpClient>((i) => HttpClient())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/dashboard", module: DashboardModule()),
        ModuleRoute("/store", module: StoreModule()),
        ModuleRoute("/signup", module: SignUpModule()),
        ModuleRoute("/signin", module: SignInModule()),
      ];
}
