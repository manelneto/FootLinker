import 'package:app/view/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser!;
    _user.updateDisplayName('Footlinker');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Principal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            iconSize: 35,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StartPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            if (_user?.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(_user!.photoURL!),
                radius: 50,
              ),
            const SizedBox(height: 16),
            Text(
              _user?.displayName ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(_user?.email ?? ''),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => StartPage()),
                );
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
