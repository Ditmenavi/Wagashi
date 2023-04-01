import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:flutter/foundation.dart';
import 'user_avatar.dart';
import 'package:ditmenavi3/api_calls.dart';

// ignore: must_be_immutable
class UniversalBody extends StatelessWidget {
  int crossAxisCount;
  double railWidth;
  UniversalBody({super.key, required this.crossAxisCount, required this.railWidth});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Body(
            crossAxisCount: crossAxisCount,
            railWidth: railWidth,
          )
        : Body(
            crossAxisCount: crossAxisCount,
            railWidth: railWidth,
          );
  }
}

// ignore: must_be_immutable
class Body extends StatefulWidget {
  int crossAxisCount;
  double railWidth;
  Body({super.key, required this.crossAxisCount, required this.railWidth});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final String? email = FirebaseAuth.instance.currentUser!.email;
  Future<String?>? displayNameFuture;

  @override
  void initState() {
    super.initState();
    displayNameFuture = Future.delayed(const Duration(seconds: 3))
        .then((_) => getUserDisplayName(email!), onError: (error) => print('Error: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Scaffold(
          appBar: AppBar(
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
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      double railWidth = widget.railWidth;
                      double availableWidth = MediaQuery.of(context).size.width - railWidth - 28;
                      double maxWidth = availableWidth > 840 ? 840 : availableWidth;
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: maxWidth,
                        ),
                        child: MasonryGridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 20,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 14,
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.crossAxisCount),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: colorScheme.primary, width: 1.5),
                                    borderRadius: BorderRadius.circular(16),
                                    color: colorScheme.surfaceTint.withOpacity(0.12),
                                  ),
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      '$index',
                                      style: TextStyle(color: colorScheme.primary),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
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

// // ignore: must_be_immutable
// class WebBody extends StatefulWidget {
//   int crossAxisCount;
//   double railWidth;
//   WebBody({super.key, required this.crossAxisCount, required this.railWidth});

//   @override
//   State<WebBody> createState() => _WebBodyState();
// }

// class _WebBodyState extends State<WebBody> {
//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   // Controllers
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     // initialize scroll controllers
//     _scrollController = ScrollController();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         final colorScheme = Theme.of(context).colorScheme;
//         return WebSmoothScroll(
//           scrollOffset: 100,
//           animationDuration: 130,
//           controller: _scrollController,
//           child: SingleChildScrollView(
//             controller: _scrollController,
//             physics: const NeverScrollableScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             child: Center(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   LayoutBuilder(
//                     builder: (BuildContext context, BoxConstraints constraints) {
//                       double railWidth = widget.railWidth;
//                       double availableWidth = MediaQuery.of(context).size.width - railWidth;
//                       double maxWidth = availableWidth > 840 ? 840 : availableWidth;
//                       return ConstrainedBox(
//                         constraints: BoxConstraints(
//                           maxWidth: maxWidth,
//                         ),
//                         child: MasonryGridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: 50,
//                           mainAxisSpacing: 10,
//                           crossAxisSpacing: 10,
//                           gridDelegate:
//                               SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.crossAxisCount),
//                           itemBuilder: (context, index) {
//                             return Container(
//                               color: colorScheme.primary,
//                               height: 200,
//                               child: Center(
//                                 child: Text(
//                                   '$index',
//                                   style: TextStyle(color: colorScheme.onPrimary),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }