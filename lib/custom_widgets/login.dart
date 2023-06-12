import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './expanded_button.dart';
import './login_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_providers.dart';

class LoginPage extends StatefulWidget {
  final Function()? register;
  const LoginPage({super.key, required this.register});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();
  FocusNode fieldThree = FocusNode();

  void signUserIn() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: Dialog(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Đang đăng nhập...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userNameController.text, password: passwordController.text);
      // ignore: use_build_context_synchronously
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      if (mounted) {
        Navigator.pop(context);
      }
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: Dialog(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.psychology_alt_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Người dùng không tồn tại',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: Dialog(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.psychology_alt_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Mật khẩu không chính xác',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else if (userNameController.text == '' && passwordController.text == '') {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: Dialog(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.psychology_alt_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Đã nhập cái lồn gì đâu mà đòi đăng nhập?',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/logo-01.svg',
                    height: 128,
                    width: 128,
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Text(
                    'Đăng nhập',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: LoginInput(
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldTwo);
                      },
                      focusNode: fieldOne,
                      controller: userNameController,
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: LoginInput(
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldThree);
                      },
                      focusNode: fieldTwo,
                      controller: passwordController,
                      hintText: 'Mật khẩu',
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ExpandedButton(
                      focusNode: fieldThree,
                      onTap: signUserIn,
                      text: 'Đăng nhập',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Quên mật khẩu?',
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: widget.register,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Đăng ký',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  const LoginProviders(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
