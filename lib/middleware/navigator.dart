import 'package:flutter_codebase/config/appstate.dart';
import 'package:redux/redux.dart';

/*
    Fluro navigator middleware

    For check if receiving [NavigateAction] then start navigating by parameters given.
    * You can do more navigating method at your own here like popUntil(), pushAndReplacement() or something else.
*/
void fluroMiddleware<State>(
    Store<State> store,
    dynamic action,
    NextDispatcher next
) { 
    next(action);

    if (action is PopCurrent)
    {
        AppState.navigatorKey.currentState.pop();
    }
    else if (action is ReplaceWith)
    {
        AppState.navigatorKey.currentState.popAndPushNamed(action.target);
    }
    else if (action is PushNew)
    {
        AppState.navigatorKey.currentState.pushNamed(action.target);
    }
}

class ReplaceWith
{
    String target;

    ReplaceWith(this.target);
}

class PopCurrent
{
    PopCurrent();
}

class PushNew
{
    String target;

    PushNew(this.target);
}