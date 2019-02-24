import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codebase/pages/SplashScreen.dart';

List<RouteDefinition> routers = [
    RouteDefinition(
        routePath: "/splash",
        widget: (params) => SplashScreen(),
        transitionType: TransitionType.inFromLeft
    ),
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