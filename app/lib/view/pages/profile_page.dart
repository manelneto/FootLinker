import 'package:app/view/pages/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    Stream<DocumentSnapshot<Map<String, dynamic>>> userStream =
        userDoc.snapshots();

    return Scaffold(
      key: const Key('profilePage'),
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        actions: [
          IconButton(
            key: const Key('logoutButton'),
            icon: const Icon(Icons.exit_to_app),
            iconSize: 25,
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StartPage(
                    navigatorKey: navigatorKey,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userStream,
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final userData = snapshot.data!.data();

          return Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.photoURL != null)
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                      radius: 50,
                    ),
                  )
                else
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 75,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "${userData?['name'] ?? 'Nome'} ${userData?['surname'] ?? 'Apelido'}",
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 1,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.email,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        userData?['email'] ?? 'e-mail',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartPage(
                              navigatorKey: navigatorKey,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
