import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => new _AuthState();
}

class _AuthState extends State<Auth> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  void _signup() {
    FirebaseAuth auth;
    auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
            password: _password.text, email: _email.text)
        .whenComplete(() {
      print("Saved ${_email.text}");
      Navigator.of(context).pushNamed("/Messcreen");
    });
  }

  void _signin() {
    try {
      FirebaseAuth auth;
      auth = FirebaseAuth.instance;
      auth
          .signInWithEmailAndPassword(
              password: _password.text, email: _email.text)
          .whenComplete(() {
        Navigator.of(context).pushNamed("/Messcreen");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    controller = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.addListener(() {
      this.setState(() {});
    });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: new Container(
        margin: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new TextField(
                controller: _email,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 20.0, color: Colors.black),
                decoration: new InputDecoration(
                  labelText: "E-Mail",
                ),
              ),
            ),
            new Container(
              child: new TextField(
                controller: _password,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 20.0, color: Colors.black),
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: "Password",
                ),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 40.0, left: 20.0),
              child: new Row(
                children: <Widget>[
                  new Container(
                    child: new Container(
                      margin: EdgeInsets.only(
                          right: 45.0, top: animation.value * 10),
                      child: new FlatButton(
                        onPressed: () {
                          _signin();
                        },
                        child: new Text(
                          "Sign In",
                          style: new TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      "Or",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                  new Container(
                    child: new Container(
                      margin: EdgeInsets.only(
                          left: 45.0, top: animation.value * 10),
                      child: new FlatButton(
                        onPressed: () {
                          _signup();
                        },
                        child: new Text(
                          "Sign Up",
                          style: new TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
