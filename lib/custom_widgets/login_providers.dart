import 'package:ditmenavi3/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ditmenavi3/api_calls.dart';

class LoginProviders extends StatefulWidget {
  const LoginProviders({super.key});

  @override
  State<LoginProviders> createState() => _LoginProvidersState();
}

class _LoginProvidersState extends State<LoginProviders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Hoặc',
                  style: TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: FilledButton.tonalIcon(
                onPressed: () async {
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
                  await FirebaseAuth.instance.signInAnonymously();
                  // ignore: use_build_context_synchronously
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(
                  Icons.account_circle_rounded,
                  size: 24,
                ),
                label: const Text(
                  'Khách',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 40,
              child: FilledButton.tonalIcon(
                onPressed: () async {
                  await AuthService().signInWithGoogle();
                  ApiCalls.importUser(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    FirebaseAuth.instance.currentUser!.photoURL.toString(),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.google,
                  size: 21,
                ),
                label: const Text(
                  'Google',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
