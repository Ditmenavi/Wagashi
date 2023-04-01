import 'package:ditmenavi3/custom_widgets/login.dart';
import 'package:ditmenavi3/custom_widgets/signup.dart';
import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool showLogin = true;
  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(
        register: togglePages,
      );
    } else {
      return SignupPage(
        register: togglePages,
      );
    }
  }
}
