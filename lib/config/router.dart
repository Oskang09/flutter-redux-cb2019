import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codebase/pages/LoginPage/views.dart';
import 'package:flutter_codebase/pages/SplashScreen.dart';
import 'package:flutter_codebase/pages/TodoPage/views.dart';

List<RouteDefinition> routers = [
    RouteDefinition(
        routePath: "/",
        widget: (params) => LoginPage(),
        transitionType: TransitionType.inFromLeft
    ),
    RouteDefinition(
        routePath: "/splash",
        widget: (params) => SplashScreen(),
        transitionType: TransitionType.inFromLeft
    ),
    RouteDefinition(
        routePath: "/home",
        widget: (params) => TodoPage(),
        transitionType: TransitionType.inFromLeft
    )
];

class RouteDefinition
{
    final String routePath;
    final WidgetRoute widget;
    final TransitionType transitionType;

    const RouteDefinition({
        this.routePath,
        this.widget,
        this.transitionType
    });
}

typedef WidgetRoute = Widget Function(Map<String, List<String>>);