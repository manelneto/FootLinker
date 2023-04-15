import 'package:app/view/pages/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser!;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(_user.uid);
    Stream<DocumentSnapshot<Map<String, dynamic>>> userStream = userDoc.snapshots();


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
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!.data();

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 32),
                if (_user?.photoURL != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(_user!.photoURL!),
                    radius: 50,
                  ) else CircleAvatar(
                  child: Icon(
                    FontAwesome.user,
                    size: 80,
                    color: Colors.green[900],
                  ),
                  radius: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  userData?['first name'] + ' ' + userData?['last name'] ?? _user.displayName ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text( 'Email: ' + userData?['email'] ?? ''),
                const SizedBox(height: 8),
                Text('Idade: ${userData?['age']?.toString() ?? ''}'),
                const SizedBox(height: 8),
                Text( 'Telemóvel: ' + userData?['phone'] ?? ''),
                const SizedBox(height: 8),
                Text( 'Distrito: ' + userData?['location'] ?? ''),
                const SizedBox(height: 40),
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
          );
        },
      ),
    );
  }
}


