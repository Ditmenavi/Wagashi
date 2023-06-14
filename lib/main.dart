import 'package:ditmenavi3/firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './url_strategy_native.dart' if (dart.library.html) './url_strategy_web.dart';
import './auth.dart';
import './context_wrapper.dart';
import 'custom_widgets/body.dart';
import 'package:flutter/services.dart';

// * For future me
// * If you got stuck with a bug what you don't know how to fix,
// ! try run "flutter clean" to clean the fucking build cache.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await AuthService().getOrCreateUser();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Color(0xff1B1B1B), // status bar color
  ));
  runApp(const MyApp());
  urlConfig();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final defaultFallbackColorScheme =
      ColorScheme.fromSeed(seedColor: const Color(0xff006f18), brightness: Brightness.light);

  static final defaultFallbackColorSchemeDark =
      ColorScheme.fromSeed(seedColor: const Color(0xff006f18), brightness: Brightness.dark);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ContextWrapper(
        context: context,
        child: DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            return MaterialApp(
              title: 'DitmeNavi',
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.dark,
              theme: ThemeData(
                colorScheme: lightDynamic ?? MyApp.defaultFallbackColorScheme,
                useMaterial3: true,
                fontFamily: 'Montserrat',
              ),
              darkTheme: ThemeData(
                colorScheme: darkDynamic ?? MyApp.defaultFallbackColorSchemeDark,
                useMaterial3: true,
                fontFamily: 'Montserrat',
              ),
              routes: {
                '/auth': (context) => const AuthPage(),
                '/home': (context) => UniversalBody(crossAxisCount: 1, railWidth: 0)
              },
              home: const AuthPage(),
            );
          },
        ),
      ),
    );
  }
}

// * Responsive
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
          return UniversalBody(
            crossAxisCount: 1,
            railWidth: 0,
          );
        } else if (constraints.maxWidth < 840) {
          return UniversalBody(
            crossAxisCount: 1,
            railWidth: 0,
          );
        } else {
          return UniversalBody(
            crossAxisCount: 1,
            railWidth: 0,
          );
        }
      },
    );
  }
}
