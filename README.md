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
