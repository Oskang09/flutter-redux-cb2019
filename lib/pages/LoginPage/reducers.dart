import 'package:flutter_codebase/pages/LoginPage/actions.dart';
import 'package:flutter_codebase/pages/LoginPage/models.dart';

LoginState loginReducer (LoginState prevState, dynamic action)
{
    if (action is LoginRequest)
    {
        if (action.name.isEmpty)
        {
            prevState.isFetching = false;
            prevState.message = "Please input a valid name";
        }
        else if (action.password.isEmpty)
        {
            prevState.isFetching = false;
            prevState.message = "Please input your password";
        }
        else
        {
            prevState.isFetching = true;
            prevState.message = "Verifying ...";
        }
    }
    else if (action is LoginSuccess)
    {
        prevState.isFetching = false;
        prevState.isSuccess = true;
        prevState.message = action.message;
    }
    else if (action is LoginFail)
    {
        prevState.isFetching = false;
        prevState.message = action.error;
    }
    return prevState;
} 