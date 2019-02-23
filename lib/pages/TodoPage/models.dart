class TodoState
{
    String doing;
    List<Todo> todos = List();
    List<Todo> filteredTodo = List();
}

class Todo
{
    int id;
    String name;
    TodoFilter filter;

    Todo({
        this.name,
        this.filter,
        this.id
    });
}

enum TodoFilter
{
    COMPLETE,
    INCOMPLETE
}