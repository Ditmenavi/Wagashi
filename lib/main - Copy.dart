import 'package:flutter/material.dart';
import './url_strategy_native.dart'
    if (dart.library.html) './url_strategy_web.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        colorSchemeSeed: const Color(0xff006f18),
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Montserrat'),
    home: const Home(),
  ));
  urlConfig();
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: Center(
        child: FilledButton.tonalIcon(
          onPressed: () {},
          label: const Text("sdgszdfcrgb"),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
