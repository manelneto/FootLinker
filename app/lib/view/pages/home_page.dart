import 'package:app/states/followed_state.dart';
import 'package:app/states/history_state.dart';
import 'package:app/states/schedule_state.dart';
import 'package:app/view/pages/followed_page.dart';
import 'package:app/view/pages/history_page.dart';
import 'package:app/view/pages/profile_page.dart';
import 'package:app/view/pages/schedule_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  void _navigateToProfilePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfilePage(navigatorKey: navigatorKey),
      ),
    );
  }

  void _navigateToFollowedPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FollowedPage(),
      ),
    );
  }

  void _navigateToSchedulePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SchedulePage(),
      ),
    );
  }

  void _navigateToHistoryPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HistoryPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    context.watch<FollowedState>().fetch(user);
    context.watch<HistoryState>().fetch(user);
    context.watch<ScheduleState>().fetch(user);

    return Scaffold(
      key: const Key('homePage'),
      appBar: AppBar(
        title: const Text(
          'FootLinker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        actions: [
          IconButton(
            key: const Key('profileButton'),
            icon: const Icon(Icons.person),
            iconSize: 30,
            onPressed: () => _navigateToProfilePage(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton.icon(
                key: const Key('followedButton'),
                onPressed: () => _navigateToFollowedPage(context),
                icon: const Icon(
                  Icons.favorite,
                  size: 40,
                ),
                label: const Text(
                  'Favoritos',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton.icon(
                key: const Key('scheduleButton'),
                onPressed: () => _navigateToSchedulePage(context),
                icon: const Icon(
                  Icons.calendar_month,
                  size: 40,
                ),
                label: const Text(
                  'Calendário',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton.icon(
                key: const Key('historyButton'),
                onPressed: () => _navigateToHistoryPage(context),
                icon: const Icon(
                  Icons.history,
                  size: 40,
                ),
                label: const Text(
                  'Histórico',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
