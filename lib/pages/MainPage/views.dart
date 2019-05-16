import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_codebase/config/singleton.dart';
import 'package:flutter_codebase/util/DeviceQuery.dart';

import 'models.dart';

class MainPage extends StatefulWidget {
    @override
    _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

    MainState state;

    @override
    void initState() {
        super.initState();
        state = MainState(this.setState);
    }

    @override
    void dispose() {
        state.serviceController.dispose();
        state.hostController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        state.device = DeviceQuery(context);
        return Scaffold(
            body: getWidgetByIndex(state.index),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (newIndex) {
                    setState(() {
                      state.index = newIndex;
                    });
                },
                items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        title: Text("Socket"),
                        icon: Icon(Icons.developer_board)
                    ),
                    BottomNavigationBarItem(
                        title: Text("Response"),
                        icon: Icon(Icons.pageview)
                    ),
                ],
            ),
        );
    }

    Widget getWidgetByIndex(int index) {
        Widget widget;
        switch (index) {
            case 0:
                widget = socketWidget();
                break;
            case 1:
                widget = outputPanel();
                break;
        }
        return widget;
    }

    Widget socketWidget() {
        return Column(
            children: <Widget>[
                Flexible(
                    flex: 1,
                    child: Column(
                        children: <Widget>[
                            connectionBar(),
                            connectionButtonBar()
                        ],
                    )
                ),
                Flexible(
                    flex: 1,
                    child: Column(
                        children: <Widget>[
                            actionBar(),
                            actionButtonBar()
                        ],
                    )
                ),
                Flexible(
                    flex: 1,
                    child: Column(

                    )
                )
            ],
        );
    }

    Widget connectionBar() {
        return Flexible(
            flex: 1,
                child: Row(
                children: <Widget>[
                    Flexible(
                        flex: 4,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: state.device.getXdp(10), 
                                right: state.device.getXdp(5), 
                                top: state.device.getXdp(5)
                            ),
                            child: DropdownButton(
                                isExpanded: true,
                                value: state.selectedProtocol,
                                items: <String>[ 'https://', 'http://' ].map((String action) {
                                    return DropdownMenuItem<String>(
                                        value: action,
                                        child: Text(action),
                                    );
                                }).toList(),
                                hint: Text("Protocol"),
                                onChanged: state.updateProtocol,
                            ),
                        ),
                    ),
                    Flexible(
                        flex: 6,
                        child: Container(
                            margin: EdgeInsets.only(right: state.device.getXdp(10)),
                            child: TextField(
                                controller: state.hostController,
                                decoration: InputDecoration(
                                    labelText: "Host",
                                    hintText: "Input server ip ( includes port )."
                                ),
                            ),
                        ),
                    )
                ],
            ),
        );
    }

    Widget connectionButtonBar() {
        return Flexible(
            flex: 1,
            child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    RaisedButton(
                        child: Text("Connect"), 
                        onPressed: () {
                            AppSingleton.socket.connect(state.getConnectionString(), () {
                                this.setState(() {
                                    state.response = {
                                        'ok': true,
                                        'host': state.getConnectionString()
                                    };
                                });
                            });
                        },
                    ),
                    RaisedButton(
                        child: Text("Login"),
                        onPressed: () {
                            // AppSingleton.socket.auth('local', {
                            //     'username': 'oska',
                            //     'password': 'oskang09',
                            // }, (Map error, [ Map data ]) {
                            //     print(error);
                            //     print(data);
                            // });

                            AppSingleton.socket.auth('custom', {
                                'token': 'eyJleHAiOjE1NjU1NzYyODEsIm5hbWUiOiJ0YW0sIGtlbHZpbiIsImlkIjo1MTMxMjUsInRva2VuIjoiMXZNd2l6MnJWQnFTNkhKT3BCUExCMHdOdXpOZjRYaF8ifQ==.8f7c853dfba6cfa5ae026803c369a90d9cc25ff9230fbc41d8117f92d334ab42'
                            }, (Map error, [Map data]) {
                                this.setState( () {
                                    state.response = error ?? data;
                                });
                            });
                        },
                    ),
                    RaisedButton(
                        child: Text("Logout"), 
                        onPressed: () {

                        },
                    ),
                ],
            )
        );
    }

    Widget actionButtonBar() {
        return Flexible(
            flex: 1,
            child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    RaisedButton(
                        child: Text('Send'),
                        onPressed: () {
                            AppSingleton.socket.emit(state.selectedAction, [
                                state.serviceController.value.text
                            ], (Map error, [ Map data ]) {
                                this.setState( () {
                                    state.response = error ?? data;
                                });
                            });
                        },
                    ),
                    RaisedButton(
                        child: Text('Subscribe'),
                        onPressed: () {

                        },
                    ),
                ],
            ),
        );
    }
    
    Widget actionBar() {
        return Flexible(
            flex: 1,
            child: Row(
                children: <Widget>[
                    Container(
                        width: state.device.getXdp(40),
                        margin: EdgeInsets.only(
                            left: state.device.getXdp(10),
                            bottom: state.device.getXdp(5),
                        ),
                        child: TextField(
                            controller: state.serviceController,
                            decoration: InputDecoration(
                                labelText: "Service",
                                hintText: "Input service name ( must same with server-side naming )."
                            ),
                        ),
                    ),
                    Container(
                        width: state.device.getXdp(35),
                        margin: EdgeInsets.only(
                            left: state.device.getXdp(5),
                            right: state.device.getXdp(5),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            value: state.selectedAction,
                            items: <String>[ 'find', 'get', 'create', 'update', 'patch', 'remove' ].map((String action) {
                                return DropdownMenuItem<String>(
                                    value: action,
                                    child: Text(action),
                                );
                            }).toList(),
                            hint: Text("Please select an action"),
                            onChanged: (String newAction) {
                                this.setState(() {
                                    state.selectedAction= newAction;
                                });
                            },
                        ),
                    )
                ],
            ),
        );
    }

    Widget outputPanel() {
        // become listview and clickable to show modal
        return Column(
            children: <Widget>[
                Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                        child: Text(state.encoder.convert(state.response)),
                    )
                ),
            ],
        );
        // return StoreConnector<AppState, List<Map>>(
        //     converter: (store) => store.state.main.logs,
        //     builder: (context, logs) {
        //         return ListView(
        //             shrinkWrap: true,
        //             children: logs.map(
        //                 (log) {
        //                     return ListTile(

        //                     );
        //                 }
        //             ).toList(),
        //         );
        //     }
        // );
    }
}