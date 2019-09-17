import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_final/core/constants.dart/route_path.dart';
import 'package:smart_home_final/core/view_model/view/login_view_model.dart';
import 'package:smart_home_final/ui/views/base_widget.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(authenticationService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white54,
        body: Center(
          child: loginBody(model),
        ),
      ),
    );
  }

  loginBody(LoginViewModel model) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields(model)],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            colors: Colors.green,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome to Smart Home KHN",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  loginFields(LoginViewModel model) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  labelText: "Username",
                ),
                controller: _usernameController,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
                controller: _passwordController,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: model.busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      shape: StadiumBorder(),
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () async {
                        print('USERNAME: ${_usernameController.text}');
                        var loginSuccess = await model.login(_usernameController.text);
                        if (loginSuccess) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RoutePaths.Home, ModalRoute.withName('home'));
                        }
                      },
                    ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  "SIGN UP FOR AN ACCOUNT",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.grey,
                onPressed: () async {
                  // var loginSuccess = await model.login(_controller.text);
                  // if (loginSuccess) {
                  //   Navigator.pushNamedAndRemoveUntil(
                  //       context, RoutePaths.Home, ModalRoute.withName('/'));
                  // }
                  print('SIGN UP BTN');
                },
              ),
            ),
          ],
        ),
      );
}
