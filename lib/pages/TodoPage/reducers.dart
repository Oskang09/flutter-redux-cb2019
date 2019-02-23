import 'package:flutter_codebase/pages/TodoPage/actions.dart';
import 'package:flutter_codebase/pages/TodoPage/models.dart';
import 'package:flutter_codebase/pages/TodoPage/selectors.dart';

TodoState todoReducer(TodoState prevState, dynamic action)
{
    if (action is CreateTodo)
    {
        if (action.addAsync)
        {
            prevState.doing = "New todo with ID " + action.id.toString() + " will add after 3 seconds ...";
        }
        else
        {
            prevState.todos.add(Todo(
                id: action.id,
                name: action.name,
                filter: action.filter
            ));
            prevState.doing = "Added new todo with ID = " + action.id.toString();
        }
    }
    else if (action is DeleteTodo)
    {
        prevState.todos.removeWhere(
            (todo) => todo.id == action.id
        );
        prevState.doing = "Removed todo where ID = " + action.id.toString();
    }
    else if (action is GetTodoByFilter)
    {
        switch (action.filter)
        {
            case TodoFilter.COMPLETE:
                prevState.filteredTodo = doneTodoSelector(prevState);
                prevState.doing = "Filtering todo with COMPLETE Selector";
                break;
            case TodoFilter.INCOMPLETE:
                prevState.filteredTodo = incompleteTodoSelector(prevState);
                prevState.doing = "Filtering todo with INCOMPLETE Selector";
                break;
        }
    }
    else if (action is GetAllTodo)
    {
        prevState.filteredTodo = todoSelector(prevState);
        prevState.doing = "Get all todo.";
    }
    else if (action is GetTodoNameShorterThanSix)
    {
        prevState.filteredTodo = nameLengthTodoSelector(prevState);
        prevState.doing = "Filtering todo that name shorter than six.";
    }
    return prevState;
}