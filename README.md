### Plugins 

* Redux as "State Management"
* Fluro as "Navigator Router"

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
