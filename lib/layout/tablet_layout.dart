import 'package:flutter/material.dart';
import '../custom_widgets/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ditmenavi3/auth.dart';

class BuildTabletLayout extends StatefulWidget {
  const BuildTabletLayout({super.key});

  @override
  State<BuildTabletLayout> createState() => _BuildTabletLayoutState();
}

class _BuildTabletLayoutState extends State<BuildTabletLayout> {
  int _selectenIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = true;
  bool showTrailing = false;
  double groupAlignment = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationRail(
              backgroundColor: Theme.of(context).colorScheme.surfaceTint.withOpacity(0.08),
              selectedIndex: _selectenIndex,
              groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectenIndex = index;
                });
              },
              labelType: labelType,
              leading: showLeading
                  ? Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/logo-01.svg',
                            height: 56,
                            width: 56,
                            // ignore: deprecated_member_use
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            AuthService().signUserOut();
                          },
                          child: const Icon(Icons.send_rounded),
                        ),
                      ],
                    )
                  : const SizedBox(),
              trailing: showTrailing
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded),
                    )
                  : const SizedBox(),
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.verified_outlined),
                    selectedIcon: Icon(Icons.verified_rounded),
                    label: Text('Verified'),
                    padding: EdgeInsets.all(4.0)),
                NavigationRailDestination(
                    icon: Icon(Icons.favorite_border_outlined),
                    selectedIcon: Icon(Icons.favorite_rounded),
                    label: Text('Following'),
                    padding: EdgeInsets.all(4.0)),
                NavigationRailDestination(
                    icon: Icon(Icons.explore_outlined),
                    selectedIcon: Icon(Icons.explore_rounded),
                    label: Text('Random'),
                    padding: EdgeInsets.all(4.0)),
                NavigationRailDestination(
                    icon: Icon(Icons.home_repair_service_outlined),
                    selectedIcon: Icon(Icons.home_repair_service_rounded),
                    label: Text('Tools'),
                    padding: EdgeInsets.all(4.0)),
              ],
            ),
            Expanded(
              child: UniversalBody(
                crossAxisCount: 2,
                railWidth: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
