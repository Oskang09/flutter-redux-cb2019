import 'dart:async';
import 'dart:ui';

import 'package:flutter_codebase/pages/LoginPage/actions.dart';
import 'package:flutter_codebase/config/appstate.dart';
import 'package:flutter_codebase/middleware/navigator.dart';
import 'package:redux/redux.dart';

Middleware<AppState> loginAsync = (Store<AppState> store, dynamic action, NextDispatcher next) async
{
    next(action);
    
    if (action is LoginRequest && store.state.login.isFetching)
    {
        VoidCallback futureDispatch;
        if (action.password == "password")
        {
            futureDispatch = () {
                Future.delayed(
                    Duration(seconds: 2),
                    () => store.dispatch(ReplaceWith("/home")));
                store.dispatch(LoginSuccess("Login sucessfully."));
            };
        }
        else
        {
            futureDispatch = () => store.dispatch(LoginFail("Invalid password. Try again."));
        }

        Future.delayed(
            Duration(seconds: 3),
            futureDispatch
        );
    }
};