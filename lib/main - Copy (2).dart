import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import './url_strategy_native.dart'
    if (dart.library.html) './url_strategy_web.dart';

void main() {
  runApp(const MyApp());
  urlConfig();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final defaultFallbackColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xff006f18), brightness: Brightness.light);

  static final defaultFallbackColorSchemeDark = ColorScheme.fromSeed(
      seedColor: const Color(0xff006f18), brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            themeMode: ThemeMode.system,
            theme: ThemeData(
              colorScheme: lightDynamic ?? defaultFallbackColorScheme,
              useMaterial3: true,
              fontFamily: 'Montserrat',
            ),
            darkTheme: ThemeData(
              colorScheme: darkDynamic ?? defaultFallbackColorSchemeDark,
              useMaterial3: true,
              fontFamily: 'Montserrat',
            ),
            home: const Home()),
      );
    });
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                onPressed: () {},
                label: const Text('Primary'),
                icon: const Icon(
                  Icons.add,
                ),
              ),
              FloatingActionButton.extended(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                splashColor: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.12),
                focusColor: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.12),
                hoverColor: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.08),
                onPressed: () {},
                label: const Text('Secondary'),
                icon: const Icon(
                  Icons.add,
                ),
              ),
              FloatingActionButton.extended(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onTertiaryContainer,
                splashColor: Theme.of(context)
                    .colorScheme
                    .onTertiaryContainer
                    .withOpacity(0.12),
                focusColor: Theme.of(context)
                    .colorScheme
                    .onTertiaryContainer
                    .withOpacity(0.12),
                hoverColor: Theme.of(context)
                    .colorScheme
                    .onTertiaryContainer
                    .withOpacity(0.08),
                onPressed: () {},
                label: const Text('Tertiary'),
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
