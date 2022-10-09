import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// import 'package:hook_up_rent/pages/home/index.dart';
// import 'package:hook_up_rent/pages/login.dart';
import 'package:hook_up_rent/routes.dart';
import 'package:hook_up_rent/scoped_model/auth.dart';
import 'package:hook_up_rent/scoped_model/city.dart';
import 'package:hook_up_rent/scoped_model/room_filter.dart';
import 'package:scoped_model/scoped_model.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    final app = MaterialApp(
      onGenerateRoute: router.generator,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
        primary: Colors.green, //顶部导航栏颜色
        onPrimary: Colors.white, //顶部导航栏字体颜色
      )),
    );
    return ScopedModel<CityModel>(
        model: CityModel(),
        child: ScopedModel<AuthModel>(
            model: AuthModel(),
            child: ScopedModel<FilterBarModel>(
              model: FilterBarModel(),
              child: app,
            )));
  }
}
