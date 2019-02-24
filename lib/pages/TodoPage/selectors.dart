import 'package:flutter_codebase/pages/TodoPage/models.dart';

final doneTodoSelector = (List<Todo> todos) => todos.where(
	(todo) => todo.filter == TodoFilter.COMPLETE
).toList();

final incompleteTodoSelector = (List<Todo> todos) => todos.where(
	(todo) => todo.filter == TodoFilter.INCOMPLETE
).toList();