import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_codebase/config/singleton.dart';

class SplashScreen extends StatelessWidget
{
    SplashScreen() {
        Future.delayed(
            Duration(seconds: 3),
            () {
                AppSingleton.navigate('pop');
            }
        );
    }
    
    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            backgroundColor: Colors.blueAccent,
            body: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("assets/icon.png"),
                )
            )
        );
    }
}