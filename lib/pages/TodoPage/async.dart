import 'dart:async';

import 'package:flutter_codebase/pages/TodoPage/actions.dart';
import 'package:flutter_codebase/config/appstate.dart';
import 'package:redux/redux.dart';

Middleware<AppState> todoAsync = (Store<AppState> store, dynamic action, NextDispatcher next) async
{
    next(action);
    
    if (action is CreateTodo && action.addAsync)
    {
        Future.delayed(
            Duration(seconds: 3),
            () => store.dispatch(CreateTodo(
                id: action.id,
                name: action.name,
                filter: action.filter
            ))
        );
    }
};