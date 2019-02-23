import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_codebase/config/appstate.dart';
import 'package:flutter_codebase/middleware/navigator.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatelessWidget
{
    @override
    Widget build(BuildContext context) 
    {
        return StoreConnector<AppState, Store<AppState>>(
            converter: (store) => store,
            onInitialBuild: (store)
            {
                /*
                    (!) Why i put this at onIntialBuild instead of builder: (context, store)?

                    Because sometimes the components update & state changed will called builder again but onIntialBuild only
                    called when firs time intialized so what you want to do when initialize just update here.
                    Components still have more lifecycle events like 'onDidChange', 'onDispose', 'onInit' and mores
                */
                Future.delayed(
                    Duration(seconds: 3),
                    () {
                        store.dispatch(PopCurrent());
                    }
                );
            },
            builder: (context, store)
            {
                return Scaffold(
                    backgroundColor: Colors.blueAccent,
                    body: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/icon.png"),
                        )
                    )
                );
            }
        );
    }
}