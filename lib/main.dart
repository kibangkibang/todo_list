import 'package:flutter/material.dart';
import 'package:to_do_list/screens/splash_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo-List',
      home: SplashScreen(),
    );
  }
}