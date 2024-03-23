import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splittr/constants/app_constants/app_constants.dart';
import 'package:splittr/constants/env/env.dart';
import 'package:splittr/core/app_config/i_app_config.dart';
import 'package:splittr/core/designs/theme/app_theme.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/core/route_handler/route_observer.dart';
import 'package:splittr/di/injection.dart';

Future<void> mainCommon(Env env) async {
  appConfig = IAppConfig.init(env);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: appConfig.firebaseOptions,
  );

  configureDependencies(env);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteId.splash.name,
      onGenerateRoute: RouteHandler.generateRoute,
      theme: AppTheme.theme,
      navigatorObservers: [
        CustomNavigatorObserver(),
      ],
    );
  }
}
