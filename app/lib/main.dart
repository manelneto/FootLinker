import 'package:app/controller/firebase_messaging_controller.dart';
import 'package:app/controller/notification_controller.dart';
import 'package:app/states/followed_state.dart';
import 'package:app/states/history_state.dart';
import 'package:app/states/schedule_state.dart';
import 'package:app/view/pages/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({
    super.key,
  });

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final navigatorKey = GlobalKey<NavigatorState>();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HistoryState()),
        ChangeNotifierProvider(create: (context) => ScheduleState()),
        ChangeNotifierProvider(create: (context) => FollowedState()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
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
            } else if (snapshot.connectionState == ConnectionState.done) {
              NotificationController notifController =
                  NotificationController(navigatorKey);
              FirebaseMessagingController fbNotif =
                  FirebaseMessagingController(notifController);

              initializeFirebaseMessaging(fbNotif);
              checkNotifications(notifController);

              return StartPage(navigatorKey: navigatorKey);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

initializeFirebaseMessaging(FirebaseMessagingController fbNotif) async {
  await fbNotif.initialize();
}

checkNotifications(NotificationController notifController) async {
  await notifController.checkForNotifications();
}
