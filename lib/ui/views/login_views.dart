import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('login'),
    );
  }
}