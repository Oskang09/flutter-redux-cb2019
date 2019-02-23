import 'package:flutter_codebase/pages/TodoPage/models.dart';
import 'package:reselect/reselect.dart';

var todoSelector = (TodoState state) => state.todos;

final doneTodoSelector = createSelector1(
    todoSelector,
    (List<Todo> todos) => todos.where(
        (todo) => todo.filter == TodoFilter.COMPLETE
    )
);

final incompleteTodoSelector = createSelector1(
    todoSelector,
    (List<Todo> todos) => todos.where(
        (todo) => todo.filter == TodoFilter.INCOMPLETE
    )
);

final nameLengthTodoSelector = createSelector1(
    todoSelector,
    (List<Todo> todos) => todos.where(
        (todo) => todo.name.length < 6
    )
);