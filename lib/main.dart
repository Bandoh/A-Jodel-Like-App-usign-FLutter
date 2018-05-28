
import 'package:firebasetrychat/Messcreen.dart';
import 'package:firebasetrychat/routes/Comments.dart';
import 'package:firebasetrychat/routes/signinRegister.dart';
import 'package:flutter/material.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        "/comments": (BuildContext context)=>new Comments(value: tex,postid: postnumber,),
        "/Messcreen":(BuildContext context)=> new Messcreen(),
      },
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return new Auth();
  }
}
