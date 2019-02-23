import 'package:flutter_codebase/pages/TodoPage/models.dart';

class GetAllTodo {}
class GetTodoNameShorterThanSix {}

class GetTodoByFilter
{
    TodoFilter filter;
}

class CreateTodo
{
    int id;
    String name;
    TodoFilter filter;
    bool addAsync;

    CreateTodo({
        this.name,
        this.filter,
        this.id,
        this.addAsync = false
    });
}

class DeleteTodo
{
    int id;

    DeleteTodo({
        this.id
    });
}