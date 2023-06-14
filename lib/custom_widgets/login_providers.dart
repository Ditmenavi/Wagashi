import 'package:ditmenavi3/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ditmenavi3/api_calls.dart';

Future<bool> isUserSignedInWithGoogle() async {
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    // Check if the user's providerData contains GoogleAuthProvider's ID
    return currentUser.providerData.any((userInfo) => userInfo.providerId == GoogleAuthProvider.PROVIDER_ID);
  } else {
    // The user is not signed in
    return false;
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                'Đang đăng nhập...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginProviders extends StatefulWidget {
  const LoginProviders({Key? key}) : super(key: key);

  @override
  State<LoginProviders> createState() => _LoginProvidersState();
}

class _LoginProvidersState extends State<LoginProviders> {
  bool _isLoading = false;

  void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const LoadingDialog();
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context); // Dismiss the loading dialog
  }

  Future<void> signInAnonymously() async {
    showLoadingDialog(context);

    try {
      await FirebaseAuth.instance.signInAnonymously();
      // Perform navigation to the desired screen after signing in
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
        hideLoadingDialog(context);
      }
    } catch (e) {
      // Handle any potential errors that occur during sign-in
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
                      Icons.error_rounded,
                      size: 64.0,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Đã có lỗi xảy ra khi đăng nhập.',
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
    }
  }

  Future<void> signInWithGoogle() async {
    showLoadingDialog(context);

    try {
      await AuthService().signInWithGoogle();
      bool isSignedIn = await isUserSignedInWithGoogle();
      if (isSignedIn) {
        // User signed in with Google
        ApiCalls.importUser(
          FirebaseAuth.instance.currentUser!.email.toString(),
          FirebaseAuth.instance.currentUser!.displayName.toString(),
          FirebaseAuth.instance.currentUser!.photoURL.toString(),
        );
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
          hideLoadingDialog(context);
        }
        if (ModalRoute.of(context)?.settings.name == '/home') {
          hideLoadingDialog(context);
        }
      } else {
        // ignore: use_build_context_synchronously
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
                        Icons.error_rounded,
                        size: 64.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Đã có lỗi xảy ra khi đăng nhập.',
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
      }
    } catch (e) {
      hideLoadingDialog(context);
      // Handle any potential errors that occur during sign-in
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
                      Icons.error_rounded,
                      size: 64.0,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Đã có lỗi xảy ra khi đăng nhập.',
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
    }
  }

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
                onPressed: signInAnonymously,
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
                onPressed: signInWithGoogle,
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
        if (_isLoading) const LoadingDialog(), // Show the loading dialog when `_isLoading` is true
      ],
    );
  }
}
