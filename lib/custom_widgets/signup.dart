import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './expanded_button.dart';
import './login_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_providers.dart';
import 'package:ditmenavi3/api_calls.dart';

class SignupPage extends StatefulWidget {
  final Function()? register;
  const SignupPage({super.key, required this.register});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final displayNameController = TextEditingController();
  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();
  FocusNode fieldThree = FocusNode();
  FocusNode fieldFour = FocusNode();
  FocusNode fieldFive = FocusNode();
  void signUserUp() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Đang đăng ký...',
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
    if (passwordController.text != confirmPasswordController.text) {
      // ignore: use_build_context_synchronously
      if (mounted) {
        Navigator.pop(context);
      }
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.password_rounded,
                      size: 64.0,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mật khẩu không khớp.',
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
      return;
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userNameController.text, password: passwordController.text);
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
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.psychology_alt_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Người dùng không tồn tại.',
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
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.psychology_alt_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Mật khẩu không chính xác.',
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
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.alternate_email_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Đã có tài khoản sử dụng Email này.',
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
      } else if (userNameController.text == '' &&
          passwordController.text == '' &&
          confirmPasswordController.text == '' &&
          displayNameController.text == '') {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.psychology_alt_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Đã nhập cái lồn gì đâu mà đòi đăng ký?',
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
    ApiCalls.importUser(userNameController.text, displayNameController.text);
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
                    'Gia nhập hang Navi',
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
                        FocusScope.of(context).requestFocus(fieldTwo);
                      },
                      focusNode: fieldTwo,
                      controller: displayNameController,
                      hintText: 'Tên hiển thị',
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
                      focusNode: fieldThree,
                      controller: passwordController,
                      hintText: 'Mật khẩu',
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: LoginInput(
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldFour);
                      },
                      focusNode: fieldFour,
                      controller: confirmPasswordController,
                      hintText: 'Xác nhận mật khẩu',
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ExpandedButton(
                      focusNode: fieldFive,
                      onTap: signUserUp,
                      text: 'Đăng ký',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
