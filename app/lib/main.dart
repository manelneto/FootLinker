import 'package:app/view/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
                return const MyHomePage();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var history = <Match>[];
  var schedule = <Match>[];

  void addToHistory(Match match, BuildContext context) {
    if (!history.contains(match)) {
      history.add(match);
      notifyListeners();
      var snackBar = SnackBar(
        content: Center(
          child: Text(
              '${match.home.name} - ${match.away.name} adicionado ao histórico!'),
        ),
        action: SnackBarAction(
          label: 'Anular',
          onPressed: () {
            history.remove(match);
            notifyListeners();
          },
        ),
        duration: const Duration(
          seconds: 1,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void removeFromHistory(Match match, BuildContext context) {
    history.remove(match);
    notifyListeners();
    var snackBar = SnackBar(
      content: Center(
        child: Text(
            '${match.home.name} - ${match.away.name} removido do histórico!'),
      ),
      action: SnackBarAction(
        label: 'Anular',
        onPressed: () {
          history.add(match);
          notifyListeners();
        },
      ),
      duration: const Duration(
        seconds: 1,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void addToSchedule(Match match, BuildContext context) {
    if (!schedule.contains(match)) {
      schedule.add(match);
      notifyListeners();
      var snackBar = SnackBar(
        content: Center(
          child: Text(
              '${match.home.name} - ${match.away.name} adicionado ao calendário!'),
        ),
        action: SnackBarAction(
          label: 'Anular',
          onPressed: () {
            schedule.remove(match);
            notifyListeners();
          },
        ),
        duration: const Duration(
          seconds: 1,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void removeFromSchedule(Match match, BuildContext context) {
    schedule.remove(match);
    notifyListeners();
    var snackBar = SnackBar(
      content: Center(
        child: Text(
            '${match.home.name} - ${match.away.name} removido do calendário!'),
      ),
      action: SnackBarAction(
        label: 'Anular',
        onPressed: () {
          schedule.add(match);
          notifyListeners();
        },
      ),
      duration: const Duration(
        seconds: 1,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
