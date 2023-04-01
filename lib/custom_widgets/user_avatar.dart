import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.photoURL == null) {
      return SvgPicture.asset(
        'assets/default-avatar.svg',
        height: 48,
        width: 48,
        // ignore: deprecated_member_use
        color: Theme.of(context).colorScheme.surfaceTint,
      );
    } else {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
              image: NetworkImage(
                FirebaseAuth.instance.currentUser!.photoURL.toString(),
              ),
              fit: BoxFit.fill),
        ),
      );
    }
  }
}
