import 'package:flutter/material.dart';
import 'package:flutter_codebase/pages/LoginPage/models.dart';
import 'package:flutter_codebase/pages/TodoPage/models.dart';

/*
    AppState

    storing all of the pages state & app state
*/
class AppState
{
    static GlobalKey<NavigatorState> navigatorKey;

    LoginState login;
    TodoState todo;
    
    AppState({
        this.login,
        this.todo
    }) 
    {
        login = login ?? LoginState();
        todo = todo ?? TodoState();
    }
}