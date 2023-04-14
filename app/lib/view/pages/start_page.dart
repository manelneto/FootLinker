import 'package:app/view/pages/history_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({
    super.key,
  });

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
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.history),
            title: const Center(
              child: Text(
                'Histórico',
                textAlign: TextAlign.center,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _navigateToHistoryPage(context);
            },
          )
        ],
      ),
    );
  }
}
