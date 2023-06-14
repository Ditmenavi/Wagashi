import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_avatar.dart';

class LegacyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LegacyAppBar({super.key});

  @override
  State<LegacyAppBar> createState() => _LegacyAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _LegacyAppBarState extends State<LegacyAppBar> {
  Future<String?>? displayNameFuture;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xff1B1B1B),
      ),
      centerTitle: true,
      title: FutureBuilder(
          future: displayNameFuture,
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData) {
              final displayName = snapshot.data ?? '';
              return Text(
                'Chào mừng trở lại, $displayName!',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              );
            } else if (snapshot.hasError) {
              return const Text(
                'Gomenasorry, anh bạn không có tên trong database của DitmeNavi 💀.',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              );
            } else {
              return const Text(
                'Đang lấy thông tin người dùng...',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              );
            }
          }),
      actions: [
        SizedBox(
          width: 56,
          height: 56,
          child: IconButton(
            onPressed: () {},
            icon: const UserAvatar(),
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ),
        ),
      ],
    );
  }
}
