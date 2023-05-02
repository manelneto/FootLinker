import 'package:app/view/pages/followed_page.dart';
import 'package:app/view/pages/history_page.dart';
import 'package:app/view/pages/profile_page.dart';
import 'package:app/view/pages/schedule_page.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
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
                onPressed: () => _navigateToFollowedPage(context),
                icon: const Icon(Icons.favorite, size: 40,),
                label: const Text('Favoritos',
                  style: TextStyle(
                    fontSize: 25,
                  ),),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton.icon(
                onPressed: () => _navigateToSchedulePage(context),
                icon: const Icon(Icons.calendar_month, size: 40,),
                label: const Text('Calendário',
                  style: TextStyle(
                    fontSize: 25,
                  ),),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton.icon(
                onPressed: () => _navigateToHistoryPage(context),
                icon: const Icon(Icons.history, size: 40,),
                label: const Text('Histórico',
                  style: TextStyle(
                    fontSize: 25,
                  ),),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
