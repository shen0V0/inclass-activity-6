import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
void main() {
setupWindow();
runApp(
// Provide the model to all widgets within the app. We're using
// ChangeNotifierProvider because that's a simple way to rebuild
// widgets when a model changes. We could also just use
// Provider, but then we would have to listen to Counter ourselves.
//
// Read Provider's docs to learn about all the available providers.
ChangeNotifierProvider(
// Initialize the model in the builder. That way, Provider
// can own Counter's lifecycle, making sure to call `dispose`
// when not needed anymore.
create: (context) => Counter(),
child: const MyApp(),
),
);
}
const double windowWidth = 360;
const double windowHeight = 640;
void setupWindow() {
if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
WidgetsFlutterBinding.ensureInitialized();
setWindowTitle('Provider Counter');
setWindowMinSize(const Size(windowWidth, windowHeight));
setWindowMaxSize(const Size(windowWidth, windowHeight));
getCurrentScreen().then((screen) {
setWindowFrame(Rect.fromCenter(
center: screen!.frame.center,
width: windowWidth,
height: windowHeight,
));
});
}
}
/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class Counter with ChangeNotifier {
int value = 0;
void increment() {
value += 1;
notifyListeners();
}
void decrease(){
  value-= 1;
  notifyListeners();
}
}
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Flutter Demo',
theme: ThemeData(
primarySwatch: Colors.blue,
useMaterial3: true,
),
home: const MyHomePage(),
);
}
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 199, 239),
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'I am ',
                  style: Theme.of(context).textTheme.headlineMedium, // Same font size
                ),
                Consumer<Counter>(
                  builder: (context, counter, child) => Text(
                    '${counter.value}', // Counter value
                    style: Theme.of(context).textTheme.headlineMedium, // Same font size
                  ),
                ),
                Text(
                  ' years old',
                  style: Theme.of(context).textTheme.headlineMedium, // Same font size
                ),
              ],
            ),
            const SizedBox(height: 20), 
            Container(
              width: 150, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 90, 149, 238), // Dark blue background
                foregroundColor: Colors.white,
                ),
                onPressed: () {
                  var counter = context.read<Counter>();
                  counter.increment();
                },
                child: const Text('Increment'),
              ),
            ),
             Container(
              width: 150, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 109, 201, 240), // Dark blue background
                foregroundColor: Colors.white,
                ),
                onPressed: () {
                  var counter = context.read<Counter>();
                  counter.decrease();
                },
                child: const Text('Decrease'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
