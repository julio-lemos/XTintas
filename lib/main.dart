import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xtintas/modules/app.module.dart';

void main() => runApp(ModularApp(module: AppModule(), child: const XTintas()));

class XTintas extends StatefulWidget {
  const XTintas({Key? key}) : super(key: key);

  @override
  State<XTintas> createState() => _XTintasState();
}

class _XTintasState extends State<XTintas> {
  final _prefs = SharedPreferences.getInstance();

  Future<void> checkAuth() async {
    final SharedPreferences prefs = await _prefs;
    final isAuth = prefs.getString('authToken')?.isNotEmpty;

    if (isAuth == true) {
      Modular.to.navigate("/profile");
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute("/signin");

    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
