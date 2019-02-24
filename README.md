# Clone

For master branch come with example, you can clone and run `flutter doctor && flutter run`
```
git clone --single-branch --branch master https://github.com/Oskang09/Flutter-CB2019.git
```

For codebase branch just empty codebase, but setup done you can just start your development.
```
git clone --single-branch --branch codebase https://github.com/Oskang09/Flutter-CB2019.git
```

# Plugins 

* Dart as "Programming Language"
* Flutter as "SDK"
* Redux as "State Management"
* Fluro as "Navigator Router"

# pubspec.yaml

```yaml
name: flutter_codebase
description: A new Flutter project.

version: 1.0.0+1

environment:
  sdk: ">=2.0.0-dev.68.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_redux: 0.5.2
  redux: 3.0.0
  fluro: ^1.4.0
  
  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
    - assets/
```

# Main Setup

Main setup is for setup some device specific options like device orientation.

```dart
void main() async 
{
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
    ]);
}
```

# Navigator & Fluro Setup

For initializing navigatorKey & fluro router setup, since for global usage so i define navigatorKey at AppState ( main state for app ). 

* [navigatorKey] for work with redux so can update screen when have redux store.
* [router] for storing fluro router's definitions, see './config/router.dart' for more information about setup router.


```dart
AppState.navigatorKey = GlobalKey<NavigatorState>();
Router router = Router();

routers.forEach(
    (route) {
        router.define(
            route.routePath,
            handler: Handler(
                handlerFunc: (context, params) => route.widget(params)
            ),
            transitionType: route.transitionType
        );
    }
);
```

# Redux Store Setup

For redux we need setup a main state for app & store for redux, when we initializing redux store we would required all of the reducers ( that we have put at reducerContainer ), appstate, and all of the middleware ( fluroMiddleware & asyncContainer ).

* [reducerContainer] is a reducerInjector storing all reducers, take a look at './config/reducers.dart'.
* [initialState] is when state initialized what will store inside state, mostly just construct new 'AppState()'.
* [middleware] is a list of middleware, currently we added 'fluroMiddleware' for navigator and 'asyncContainer' for async action injector..
    - [fluroMiddleware] is a navigator middleware, take a look at './shared/navigator.dart'.
    - [asyncContainer] is a list of async action injector middleware, take a look at './config/asyncs.dart'.

```dart
final store = new Store<AppState>(
    reducerContainer,
    initialState: AppState(),
    middleware: []
        ..add(fluroMiddleware)
        ..addAll(asyncContainer)
);
```

### Extra information for async action

(!) For async action you can also use other library like
- flutter/redux_thunk ( https://pub.dartlang.org/packages/redux_thunk )
- flutter/redux_epics ( https://pub.dartlang.org/packages/redux_epics )
- flutter/dart_saga ( https://pub.dartlang.org/packages/dart_saga )
- flutter/redux_future ( https://pub.dartlang.org/packages/redux_future )

(!) Why i don't use the existing framework ?
For personal interest i rather build myself instead of framework since i don't read documentation too much,
at least i know what i'm doing and easily maintain for future works. Also another issues is the syntax all of 
them i don't like hahha, if in react-native i would use redux_saga.

# Run App & Setup Routing, Theme

Before we run the app, we need apply *redux_store* and *fluro_router* to it.
- [title] Your app name
- [theme] Your app theme setting, take a look at './config/theme.dart'
- [initialRoute] for which page you going to show first?
- [onGenerateRoute] just follow the give apply router.generator, it's setup instruction of 'fluro'.
- [navigatorKey] apply the global key navigator state to work with redux can update navigator stack anywhere.

```dart
runApp(
    StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
            title: "Flutter Showcase",
            theme: appTheme(),
            initialRoute: "/splash",
            onGenerateRoute: router.generator,
            navigatorKey: AppState.navigatorKey,
        ),
    )
);
```

### Extra information about routing

Flutter was my second front-end framework, i'm not sure this is normally or not. 
Even you have set your [initialRoute], there still have a screen '/' at there.
For router '/' is home page will auto generate. For this app as example when i start the app
mine navigator stack will be like
                                    -----------
                                    | /splash |
                                    |     /   |
                                    ----------- 
so you will need pop out instead of replace or push when first action. If not will be weird at last.

# Workflow explaination

1. [UI Action]

This will run the `store.dispatch(ACTION)` code in ui code mean one of the ui action has been firing. ( Button Tap, GestureDetector or anything else can dispatch action )

2. [Middleware] receive action & run async middleware

This will run before reducer. since middleware is async so won't block main thread if you don't block it at other middleware.

3. [Reducer] receive action & run

This will run the action if middleware doesn't block. Missing `next(action);` at middleware will make the action stop at middleware part. Reducers will resolve based on given action and return new state.

4. [UI] 

In here UI will again read updated state and re-rendering components.

5. [Selector] 

When receiving new state and updated value, you can use selectors to filter the data based on your defined function such as filtering product price lower than 5 from a list of all products.

Lastly [State Model] is th eone who has been pass around in workflow like a football and make it work like magic. ( defined at models.dart )

### Extra information for async workflow

Almost all of the async action must have 3 state. Why? Since we don't want to block main thread on app so when async run we should define is it LOADING, SUCCESS, or FAIL in the process. Reducers aslo can receive the action and reply to users what the app doing like login, we should tell user app was logging in please wait if not they tap login no action will think like app broken or anything.

Almost all of the action must have 3 state if they wont resolve on main thread like api call, reading local data, or any async required action.

- LOADING, SUCCESS, FAIL

* LOADING for define you already requesting for action & won't receive anymore ( must make a variables 'isLoading' for checking )
* SUCCESS for define your request already success 
* FAIL    for define your request has failed

# File structure explaination

Depend on yourself likes, not needed for 100% follow my pattern.

### Configuration

* appstate.dart  - AppState ( Main state for the whole app ) 
* asyncs.dart    - Async container ( Storing all of the async middleware like injector ) 
* reducers.dart  - Reducer container ( Storing all of the reducers like injector ) 
* router.dart    - Fluro router setup code
* theme.dart     - App theme setup code

### Stateful Widget

* actions.dart    - Storing actions state classes
* async.dart      - Storing async actions function
* models.dart     - Storing page state & models
* reducers.dart   - Storing reducers function
* selectors.dart  - Storing selectors function
* views.dart      - Storing UI code

### Stateless Widget

* {widget_name}.dart  - Storing UI code


# Reference

Some good references for sharing when i use to develop & build flutter app.

* https://github.com/Solido/awesome-flutter
* https://medium.com/flutter-io
* https://stackoverflow.com/


# Credits

Thanks to Flutter Team has developed such a very good framework. Also thanks to one of my friends that is front-end developer i have used some example from him there and others developer who contribute and build some very useful framework like fluro and redux.

<img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/dart.png" height="48"> <img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/flutter.png" height="48"> <img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/fluro.png" height="48"> <img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/redux.png" height="48">  
