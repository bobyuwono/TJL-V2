import 'package:flutter/material.dart';
import 'package:login/pages/setup/welcome.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    //LoginPage.tag: (context) => LoginPage(),
    //TabBarDemo.tag: (context) => TabBarDemo(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: WelcomePage(),
      routes: routes,
    );
  }
}
