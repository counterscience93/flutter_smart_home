import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Home'),
    );
  }
}