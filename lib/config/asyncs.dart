
import 'package:flutter_codebase/pages/LoginPage/async.dart';
import 'package:flutter_codebase/pages/TodoPage/async.dart';
import 'package:flutter_codebase/config/appstate.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> asyncContainer = []
    ..add(loginAsync)
    ..add(todoAsync);