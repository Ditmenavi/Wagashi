import 'package:flutter/material.dart';
import '../custom_widgets/body.dart';
import 'package:ditmenavi3/auth.dart';

class BuildMobileLayout extends StatefulWidget {
  const BuildMobileLayout({super.key});

  @override
  State<BuildMobileLayout> createState() => _BuildMobileLayoutState();
}

class _BuildMobileLayoutState extends State<BuildMobileLayout> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: UniversalBody(
          crossAxisCount: 1,
          railWidth: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AuthService().signUserOut();
          },
          child: const Icon(Icons.send_rounded),
        ),
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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
      ),
    );
  }
}
