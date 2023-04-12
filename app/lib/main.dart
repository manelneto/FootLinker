import 'package:app/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'model/match.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'FootLinker',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Algo correu mal...');
            } else if (snapshot.hasData) {
              return const MyHomePage(title: 'FootLinker');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var history = <Match>[];

  void toggleHistory(Match match) {
    if (history.contains(match)) {
      history.remove(match);
    } else {
      history.add(match);
    }
    notifyListeners();
  }
}