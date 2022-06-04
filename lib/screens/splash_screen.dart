import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/screens/list_screen.dart';
import 'package:to_do_list/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    print('[*] isLogin: ' + isLogin.toString());
    return isLogin;
  }
  void moveScreen() async{
    await checkLogin().then((isLogin){
      if(isLogin){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListScreen()));
      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      moveScreen();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('images/logo.png',width: MediaQuery.of(context).size.width*0.8,)),
    );
  }
}