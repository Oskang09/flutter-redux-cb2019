import 'package:flutter/material.dart';
import 'package:flutter_codebase/util/FeatherSocket.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppSingleton
{
    // static SharedPreferences storage;
    static FeatherSocket socket;

    static GlobalKey<NavigatorState> navigatorKey;
    
    static void navigate(String action, [ String target ]) {
        if (action == 'pop')
        {
            AppSingleton.navigatorKey.currentState.pop();
        }
        else if (action == 'replace')
        {
            AppSingleton.navigatorKey.currentState.popAndPushNamed(target);
        }
        else if (action == 'push')
        {
            AppSingleton.navigatorKey.currentState.pushNamed(target);
        }
    }
}