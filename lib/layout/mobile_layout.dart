import 'package:flutter/material.dart';
import '../custom_widgets/body.dart';

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
      ),
    );
  }
}
