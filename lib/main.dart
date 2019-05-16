import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codebase/config/singleton.dart';
import 'package:flutter_codebase/util/FeatherSocket.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_codebase/config/router.dart';
import 'package:flutter_codebase/config/theme.dart';

void main() async
{
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
    ]);
    
    AppSingleton.navigatorKey = GlobalKey<NavigatorState>();
    // AppState.storage = await SharedPreferences.getInstance();
    AppSingleton.socket = FeatherSocket();

    Router router = Router();
    routers.forEach(
        (route) {
            router.define(
                route.routePath,
                handler: Handler(
                    handlerFunc: (context, params) => route.widget(params)
                ),
                transitionType: route.transitionType
            );
        }
    );

    runApp(MaterialApp(
        title: "Flutter Showcase",
        theme: appTheme(),
        initialRoute: "/splash",
        onGenerateRoute: router.generator,
        navigatorKey: AppSingleton.navigatorKey,
    ));
}