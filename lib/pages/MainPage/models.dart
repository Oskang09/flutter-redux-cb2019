import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_codebase/config/base_state.dart';
import 'package:flutter_codebase/config/singleton.dart';
import 'package:flutter_codebase/util/DeviceQuery.dart';

class MainState extends BaseState {

    int index;
    DeviceQuery device;
    String selectedAction;
    String selectedProtocol;
    TextEditingController serviceController;
    TextEditingController hostController;

    Map response;
    JsonEncoder encoder;

    getConnectionString() => selectedProtocol + hostController.value.text;

    MainState(Function setState) : super(setState) {
        index = 0;
        serviceController = TextEditingController(text: '');
        hostController = TextEditingController(text: '192.168.56.1:3001');
        response = { 'ok': false };
        encoder = JsonEncoder.withIndent('     ');
    }

    updateProtocol(String newProtocol) {
        selectedProtocol = newProtocol;
        updateState();
    }

    connectButton() {
        AppSingleton.socket.connect(getConnectionString(), () {
            response = { 'ok': true, 'host': getConnectionString() };
            updateState();
        });
    }
}