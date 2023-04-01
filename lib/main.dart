import 'package:ditmenavi3/firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './layout/desktop_layout.dart';
import './layout/tablet_layout.dart';
import './layout/mobile_layout.dart';
import './url_strategy_native.dart' if (dart.library.html) './url_strategy_web.dart';
import './auth.dart';

// * For future me
// * If you got stuck with a bug what you don't know how to fix,
// ! try run "flutter clean" to clean the fucking build cache.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await AuthService().getOrCreateUser();
  runApp(const MyApp());
  urlConfig();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final defaultFallbackColorScheme =
      ColorScheme.fromSeed(seedColor: const Color(0xff006f18), brightness: Brightness.light);

  static final defaultFallbackColorSchemeDark =
      ColorScheme.fromSeed(seedColor: const Color(0xff006f18), brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
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
            home: const AuthPage(),
          ),
        );
      },
    );
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return const BuildMobileLayout();
        } else if (constraints.maxWidth < 840) {
          return const BuildTabletLayout();
        } else {
          return const BuildDesktopLayout();
        }
      },
    );
  }
}
