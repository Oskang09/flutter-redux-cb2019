### Plugins 

* Dart as "Programming Language"
* Flutter as "SDK"
* Redux as "State Management"
* Fluro as "Navigator Router"

### pubspec.yaml

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

### Main Setup

```dart
void main() async 
{
    // This is for setup device orientation only
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
    ]);
}
```

### Navigator & Fluro Setup

```dart
/*
    Since for global usage so i define navigatorKey at AppState
    * [navigatorKey] for work with redux so can update screen when have redux store.
    * [router] for storing fluro router's definitions, see './config/router.dart' for more information about setup router.
*/
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

### Redux Store Setup

```dart
/*
Setup redux store

* [reducerContainer] is a reducerInjector storing all reducers, take a look at './config/reducers.dart'.
* [initialState] is when state initialized what will store inside state, mostly just construct new 'AppState()'.
* [middleware] is a list of middleware, currently we added 'fluroMiddleware' for navigator and 'asyncContainer' for async action injector..
    - [fluroMiddleware] is a navigator middleware, take a look at './shared/navigator.dart'.
    - [asyncContainer] is a list of async action injector middleware, take a look at './config/asyncs.dart'.
        (!) For async action you can also use other library like
        - flutter/redux_thunk ( https://pub.dartlang.org/packages/redux_thunk )
        - flutter/redux_epics ( https://pub.dartlang.org/packages/redux_epics )
        - flutter/dart_saga ( https://pub.dartlang.org/packages/dart_saga )
        - flutter/redux_future ( https://pub.dartlang.org/packages/redux_future )

        (!) Why i don't use the existing framework ?
        For personal interest i rather build myself instead of framework since i don't read documentation too much,
        at least i know what i'm doing and easily maintain for future works. Also another issues is the syntax all of 
        them i don't like hahha, if in react-native i would use redux_saga.
*/
final store = new Store<AppState>(
    reducerContainer,
    initialState: AppState(),
    middleware: []
        ..add(fluroMiddleware)
        ..addAll(asyncContainer)
);
```

### Run App & Setup Routing, Theme

```dart
/*
Now we run the app and apply 'redux_store' and 'fluro_router' to it.

- [title] Your app name
- [theme] Your app theme setting, take a look at './config/theme.dart'
- [initialRoute] for which page you going to show first?
    (!) Warning about navigating
    Flutter was my second front-end framework, i'm not sure this is normally or not. 
    Even you have set your [initialRoute], there still have a screen '/' at there.
    For router '/' is home page will auto generate. For this app as example when i start the app
    mine navigator stack will be like
                                        -----------
                                        | /splash |
                                        |     /   |
                                        ----------- 
    so you will need pop out instead of replace or push when first action. If not will be weird at last.

- [onGenerateRoute] just follow the give apply router.generator, it's setup instruction of 'fluro'.
- [navigatorKey] apply the global key navigator state to work with redux can update navigator stack anywhere.
*/
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

### Workflow explaination

```
1) [UI Action] ( Button Tap, GestureDetector or anything else can dispatch action )
2) [Middleware] receive action & run async middleware ( since async so won't block main thread )
3) [Reducer] receive action also if middleware doesn't blocked. reducers will resolve based on give action and return new state.
    (!) Missing 'next(action);' your action will be stop when middleware.
4) [UI] receive new state and update components with new incoming state.

(*) Optional (5) [Selectors]
When receiving new state you can use selectors to filter the data based on you defined function such as
filtering product price lower then 5 from a list of all products.

Lastly [State] is the one who has been pass around workflow like a football and make it work like a magic.

[ Async API Part ]

Almost all of the action must have 3 state if they wont resolve on main thread like ( Api Call )
- LOADING, SUCCESS, FAIL

* LOADING for define you already requesting for action & won't receive anymore ( must make a variables 'isLoading' for checking )
* SUCCESS for define your request already success 
* FAIL    for define your request has failed
```

# File structure explaination

<img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/file_structure.jpg" />

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


### Reference

Some good references for sharing when i use to develop & build flutter app.

* https://github.com/Solido/awesome-flutter
* https://medium.com/flutter-io
* https://stackoverflow.com/


### Credits

Thanks to Flutter Team has developed such a very good framework. Also thanks to one of my friends that is front-end developer i have used some example from him there and others developer who contribute and build some very useful framework like fluro and redux.

<img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/dart.png" height="48"> <img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/flutter.png" height="48"> <img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/fluro.png" height="48"> <img src="https://github.com/Oskang09/Flutter-CB2019/blob/master/media/redux.png" height="48">  
