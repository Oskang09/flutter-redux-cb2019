import 'package:flutter/material.dart';
import 'package:flutter_codebase/pages/TodoPage/actions.dart';
import 'package:flutter_codebase/pages/TodoPage/models.dart';
import 'package:flutter_codebase/config/appstate.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class TodoPage extends StatefulWidget
{
    @override
    _TodoPage createState() => _TodoPage();
}

class _TodoPage extends State<TodoPage>
{
    TodoFilter selectedFilter = TodoFilter.INCOMPLETE;
    bool isAsyncAction = false;
    TextEditingController nameController = TextEditingController();

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: body(),
        );
    }

    Widget body()
    {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    doingText(),
                    Divider(
                        color: Colors.black,
                        height: 30,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            nameInput(),
                            filterInput(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    addButton(),
                                    asyncCheckbox()
                                ],
                            ),
                        ],
                    ),
                    Divider(
                        color: Colors.black,
                        height: 30,
                    ),
                    buttonBar(),
                    display()
                ]
            )
        );
    }

    Widget doingText()
    {
        return StoreConnector<AppState, String>(
            converter: (store) => store.state.todo.doing,
            builder: (context, doing)
            {
                return Container(
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                        doing ?? "NO ACTION",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                    ),
                );
            },
        );
    }

    Widget filterInput()
    {
        return Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: DropdownButton(
                value: selectedFilter,
                isExpanded: true,
                items: TodoFilter.values.map(
                    (filter) => DropdownMenuItem<TodoFilter>(
                        value: filter,
                        child: Text(filter.toString()),
                    )
                ).toList(),
                onChanged: (action) => this.setState(() => selectedFilter = action)
            )
        );
    }

    Widget nameInput()
    {
        return Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Todo's name",
                    hintText: "Please input your todo name"
                ),
            ),
        );
    }

    Widget asyncCheckbox()
    {
        return Checkbox(
            value: isAsyncAction,
            onChanged: (action) => this.setState(() => isAsyncAction = action)
        );
    }

    Widget addButton()
    {
        return StoreConnector<AppState, VoidCallback>(
            converter: (store) => ()
            {
                int id = 0;
                if (store.state.todo.todos.length == 1)
                {
                    id = store.state.todo.todos.single.id;
                }
                if (store.state.todo.todos.length > 1)
                {
                    id = store.state.todo.todos.last.id;
                }
                store.dispatch(CreateTodo(
                    id: id + 1,
                    name: nameController.text,
                    filter: selectedFilter,
                    addAsync: isAsyncAction
                ));
            },
            builder: (context, create)
            {
                return RaisedButton(
                    child: Text("CREATE"),
                    onPressed: create,
                );
            }
        );
    }

    Widget buttonBar()
    {
        return Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    StoreConnector<AppState, VoidCallback>(
                        converter: (store) => () => store.dispatch(GetAllTodo()),
                        builder: (context, filter)
                        {
                            return RaisedButton(
                                child: Text("ALL"), 
								onPressed: filter
                            );
                        },
                    ),
                    StoreConnector<AppState, VoidCallback>(
                        converter: (store) => () => store.dispatch(GetTodoByFilter(filter: TodoFilter.COMPLETE)),
                        builder: (context, filter)
                        {
                            return RaisedButton(
                                child: Text("COMPLETE"), 
								onPressed: filter
                            );
                        },
                    ),
                    StoreConnector<AppState, VoidCallback>(
                        converter: (store) => () => store.dispatch(GetTodoByFilter(filter: TodoFilter.INCOMPLETE)),
                        builder: (context, filter)
                        {
                            return RaisedButton(
                                child: Text("INCOMPLETE"), 
								onPressed: filter
                            );
                        },
                    )
                ],
            ),
        );
    }

    Widget display()
    {
        return StoreConnector<AppState, List<Todo>>(
            converter: (store) => store.state.todo.filteredTodo != null ? store.state.todo.filteredTodo : store.state.todo.todos,
            builder: (context, todos)
            {
                return Expanded(
                    child: ListView(
                        shrinkWrap: true,
                        children: todos.map(
                            (todo) => StoreConnector<AppState, Store<AppState>>(
								converter: (store) => store,
								builder: (context, store)
								{
									return ListTile(
										leading: Text(todo.id.toString()),
										subtitle: Text(todo.filter.toString()),
										title: Text(todo.name),
										trailing: RaisedButton(
											child: Text("DEL"),
											onPressed: () => store.dispatch(DeleteTodo( id: todo.id ))
										)
									);
								}
							)
                        ).toList() ?? <Widget>[ Center(child: Text("Empty todo.")) ]
                    ),
                );
            }
        );
    }

    Widget todoId(int id)
    {
        return Container(
            color: Colors.blueAccent,
            child: Text(
                id.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white
                ),
            )
        );
    }

    Widget todoFilter(TodoFilter filter)
    {
        return Text(filter.toString());
    }

    Widget todoName(String name)
    {
        return Text(name);
    }
}