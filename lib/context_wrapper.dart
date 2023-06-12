import 'package:flutter/material.dart';

class ContextWrapper extends InheritedWidget {
  final BuildContext context;

  const ContextWrapper({
    Key? key,
    required this.context,
    required Widget child,
  }) : super(key: key, child: child);

  static ContextWrapper? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContextWrapper>();
  }

  @override
  bool updateShouldNotify(ContextWrapper oldWidget) {
    return context != oldWidget.context;
  }
}
