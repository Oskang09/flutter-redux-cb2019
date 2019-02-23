import 'package:flutter_codebase/pages/LoginPage/reducers.dart';
import 'package:flutter_codebase/pages/TodoPage/reducers.dart';
import 'package:flutter_codebase/config/appstate.dart';

AppState reducerContainer(AppState state, dynamic action) 
{
    return AppState(
        login: loginReducer(state.login, action),
        todo: todoReducer(state.todo, action)
    );
}