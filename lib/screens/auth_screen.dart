import 'package:flutter/material.dart';
import 'package:task_manager/screens/signup_screen.dart';
import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  static const id = 'auth_screen';
  String email = '';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedSignUp: toggle)
      : SignUpScreen(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
