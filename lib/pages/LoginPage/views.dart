import 'package:flutter/material.dart';
import 'package:flutter_codebase/pages/LoginPage/actions.dart';
import 'package:flutter_codebase/config/appstate.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class LoginPage extends StatefulWidget
{
    @override
    _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>
{
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            body: formBody(),
        );
    }

    Widget formBody()
    {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    logoIcon(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            emailInput(),
                            passwordInput(),
                            information()
                        ],
                    ),
                    loginButton()
                ]
            )
        );
    }

    Widget loginButton()
    {
        return StoreConnector<AppState, Store<AppState>>(
            converter: (store) => store,
            builder: (context, store)
            {
                if (store.state.login.isSuccess)
                {
                    return Padding(
                        padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                        child: Text(
                            "Will go other page after 2 seconds ...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13
                            ),
                        ),
                    );
                }
                else if (store.state.login.isFetching)
                {
                    return Padding(
                        padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                        child: Text(
                            "Running login async action & reducers ...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13
                            ),
                        ),
                    );
                }
                else
                {
                    return RaisedButton(
                        child: Text("LOGIN"),
                        onPressed: () 
                        {
                            if (!store.state.login.isFetching)
                            {
                                store.dispatch(LoginRequest(
                                    name: nameController.text,
                                    password: passwordController.text
                                ));
                            }
                        },
                    );
                }
            },
        );
    }

    Widget logoIcon()
    {
        return Image(
            image: AssetImage("assets/icon.png"),
            width: 128,
            height: 128,
        );
    }

    Widget information()
    {
        return StoreConnector<AppState, String>(
            converter: (store) => store.state.login?.message,
            builder: (context, message)
            {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                                child: Text(
                                    message ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13
                                    ),
                                ),
                            ) 
                        ),
                    ],
                );
            },
        );
    }

    Widget emailInput()
    {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                                labelText: "Name",
                                hintText: "Please input your name"
                            ),
                        ),
                    ) 
                ),
            ],
        );
    }

    Widget passwordInput()
    {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "Please input your password"
                            ),
                        ),
                    ) 
                ),
            ],
        );
    }
}