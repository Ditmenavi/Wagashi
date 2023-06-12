import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'user_avatar.dart';
import 'package:ditmenavi3/api_calls.dart';
import 'package:ditmenavi3/auth.dart';

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
  int currentPageIndex = 0;
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
          primary: true,

          // TODO Appbar, will be replaced with searchbar

          appBar: AppBar(
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
          ),

          // TODO Body, Contents will be shown here

          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        double railWidth = widget.railWidth;
                        double availableWidth = constraints.maxWidth - railWidth - 28;
                        double maxWidth = availableWidth > 840 ? 840 : availableWidth;
                        // print('railWidth: $railWidth');
                        // print('availableWidth: $availableWidth');
                        // print(constraints.maxWidth);
                        // print('railWidth: $railWidth');
                        // print('maxWidth: $maxWidth');
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: maxWidth,
                            ),
                            child: const Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec efficitur mi. Cras quam turpis, mollis eget rhoncus in, accumsan at nisl. Curabitur turpis massa, vehicula a viverra eu, semper non magna. Nulla facilisis justo sit amet eros hendrerit, nec imperdiet quam tristique. Sed imperdiet lectus et odio placerat semper. Curabitur quis tempor nulla. Fusce sagittis dolor et mi porttitor sodales. Donec id convallis lectus. Sed viverra ex augue, non efficitur eros molestie ut. Nunc non gravida neque. Aliquam lacinia metus vestibulum libero posuere, at malesuada diam fermentum. Phasellus quis libero ut sapien pellentesque ornare. Morbi magna nisl, iaculis hendrerit feugiat quis, euismod at erat. Suspendisse ultricies nisl nisi, sed semper odio placerat ac. Curabitur non diam eu lectus malesuada suscipit scelerisque vel nulla. Quisque imperdiet odio odio, quis fringilla sem lobortis a. Mauris vestibulum tortor a mollis fermentum. Ut in arcu dui. Nunc faucibus malesuada ex, id pharetra metus vehicula quis. Quisque fermentum risus metus, id malesuada libero tristique ut. Nam purus ligula, mollis at sapien id, pulvinar volutpat mauris. Praesent at tellus hendrerit, interdum lacus vitae, rhoncus erat. Curabitur sed sagittis erat, nec volutpat ipsum. Duis ante tellus, accumsan quis pharetra at, pellentesque at urna. Phasellus venenatis rutrum lorem in egestas. Donec id diam in mi fermentum sodales. Nam vel elit elit. Integer scelerisque dictum neque sit amet ultricies. Quisque quis facilisis elit. Ut id tincidunt velit, a convallis magna. Phasellus convallis iaculis euismod. Phasellus elementum velit est, tincidunt molestie ante posuere nec. Phasellus ullamcorper eleifend interdum. Nullam aliquet suscipit ligula ac malesuada. Curabitur vel elementum ligula, at sodales magna. Ut a hendrerit sapien. Sed ut consectetur quam. Sed cursus volutpat leo sed condimentum. Aliquam erat volutpat. Etiam ac varius erat. Maecenas id neque feugiat, vehicula sem at, rhoncus elit. Sed vel lectus gravida, consequat erat eu, mollis turpis. Vivamus varius tincidunt velit in cursus. Donec at mauris rutrum, ornare quam imperdiet, interdum sem. Nam sodales dui non turpis tristique vestibulum. Sed leo tellus, viverra sit amet orci in, porta mollis libero. Donec aliquet molestie pharetra. Integer sed odio euismod, ultricies odio in, convallis ligula. Donec diam nibh, posuere consequat dignissim in, laoreet at lacus. Nulla lorem magna, volutpat ac imperdiet eu, pharetra eu ante. Nam scelerisque magna a nisi facilisis varius. Nullam non tincidunt nibh, non placerat diam. Donec blandit, arcu vel sollicitudin porttitor, magna felis sagittis quam, ut sodales mauris felis at dolor. In aliquam libero at nisl facilisis molestie. Aenean nec mauris et quam lacinia vehicula sed in erat. Ut et erat sed erat finibus feugiat. Sed luctus enim id euismod vulputate. Donec eget accumsan tellus, a scelerisque sem. Sed eu neque sed orci elementum ultricies sed maximus massa. Phasellus felis leo, interdum eget lorem sit amet, congue maximus purus. Ut justo orci, aliquam sit amet tortor eget, eleifend interdum tellus. Aenean tincidunt diam at eros ultricies, eget pretium erat rutrum. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin sit amet sagittis nulla, vitae mollis mauris. Etiam lacinia elit arcu, ac gravida turpis ultrices quis. Vestibulum placerat augue ac nibh molestie, quis efficitur augue bibendum. Quisque ipsum elit, vulputate ac orci aliquet, cursus auctor ex. Maecenas fermentum lacus sed luctus dictum. Fusce molestie interdum urna vitae ullamcorper. Nullam et quam quis sem placerat pulvinar sit amet eget elit. Phasellus orci diam, gravida vitae dolor at, laoreet pretium ipsum. Vestibulum sit amet faucibus augue. Ut molestie elementum ante, eget tincidunt ante interdum at. Integer eleifend, massa et facilisis finibus, leo quam pulvinar quam, at vestibulum diam ex eget sapien. Aenean pharetra ullamcorper ipsum, quis suscipit justo accumsan eu. Sed et urna orci. Aliquam quis erat metus. Sed mi quam, malesuada in sagittis at, ullamcorper sed metus. In tellus justo, mollis a commodo eget, rutrum tristique tellus. Vivamus ac maximus nunc, ac vestibulum magna. Cras vehicula aliquam orci, et ullamcorper odio efficitur id. Fusce at lacus non mauris placerat pretium at id ipsum. Nunc et augue lobortis, venenatis ante at, accumsan libero. Curabitur molestie nec sem eget ullamcorper. Ut sed lobortis odio. Etiam ante neque, finibus quis vulputate non, consequat ut sem. Praesent sed dolor neque. Sed vitae suscipit nisi, vitae gravida mi. Vivamus vehicula elementum nunc sed faucibus. Cras consectetur pellentesque nibh, id cursus tortor aliquam vitae. Phasellus elit turpis, venenatis in augue id, sollicitudin suscipit eros. Donec tincidunt egestas nulla ac pulvinar. Sed finibus mauris vel sagittis ullamcorper. Mauris viverra, tellus ac interdum porttitor, purus neque scelerisque mauris, id ultricies orci justo id justo. Sed eget viverra nunc. Etiam a fringilla turpis, eget volutpat magna. Nullam condimentum libero quis tempus pharetra. Aenean urna magna, ornare vel hendrerit a, gravida congue ex. Praesent dignissim, massa non varius pretium, diam nibh placerat arcu, sed viverra felis ligula mattis lacus. Sed ultricies nunc ultrices augue pulvinar, vel sagittis libero tincidunt. Quisque pretium eu nisl in tristique. Ut placerat, nisl non rutrum convallis, lacus enim accumsan nisi, sed porta urna orci et tortor. Duis vestibulum malesuada sapien a lobortis. Etiam vel velit vulputate, rutrum nisl ac, interdum mi. Praesent volutpat nunc pulvinar magna ornare volutpat. In cursus gravida lacus in egestas. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris ut rhoncus purus, placerat rutrum nunc. Aenean eu condimentum tortor. Nunc vel iaculis ipsum. Etiam id dignissim libero, at cursus libero. In suscipit non dolor ultricies convallis. Integer vel lectus pharetra, accumsan massa eu, mollis sem. Mauris aliquet arcu sed nibh eleifend, et consequat turpis congue. Vestibulum faucibus congue eros ut venenatis. Praesent laoreet felis a magna malesuada, quis mattis mi bibendum. Sed sed tellus nec nunc imperdiet mollis. Mauris eget justo arcu. Proin eget placerat nisi. Duis id eleifend urna. Mauris tempor diam id risus posuere, at condimentum neque iaculis. Sed nec tortor pulvinar, eleifend mi in, sollicitudin mi. Curabitur euismod, neque ut faucibus laoreet, orci ligula mattis erat, ut imperdiet odio ipsum nec ante. Donec viverra orci ut ante tempus, at consequat sem ullamcorper. Aenean rhoncus leo interdum tellus gravida, at semper massa laoreet. Vestibulum elit ipsum, eleifend.'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TODO FAB, currently used to log out

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AuthService().signUserOut();
              Navigator.pushReplacementNamed(context, '/auth');
            },
            child: const Icon(Icons.send_rounded),
          ),

          // TODO NavBar, no functionality yet

          bottomNavigationBar: NavigationBar(
            // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.verified_outlined),
                selectedIcon: Icon(Icons.verified_rounded),
                label: 'Verified',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border_outlined),
                selectedIcon: Icon(Icons.favorite_rounded),
                label: 'Following',
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore_rounded),
                label: 'Random',
              ),
              NavigationDestination(
                icon: Icon(Icons.home_repair_service_outlined),
                selectedIcon: Icon(Icons.home_repair_service_rounded),
                label: 'Tools',
              ),
            ],
          ),
        );
      },
    );
  }
}
