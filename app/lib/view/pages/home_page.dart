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

          return Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                if (_user?.photoURL != null)
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(_user!.photoURL!),
                      radius: 50,
                    ),
                  ) 
                else Center(
                  child: CircleAvatar(
                    child: Icon(
                      FontAwesome.user,
                      size: 80,
                      color: Colors.green[900],
                    ),
                    radius: 50,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    '${userData?['first name'] ?? 'Sem nome'} ${userData?['last name'] ?? ''}' ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 28,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  height: 60,
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget> [
                    Icon(
                        Icons.email,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Email: ${userData?['email'] ?? 'Não cadastrado'}',
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Text(
                        'Idade: ${userData?['age']?.toString() ?? 'Não cadastrada'}',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Text(
                        'Telemóvel: ${userData?['phone'] ?? 'Não cadastrado'}',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Text(
                        'Distrito: ${userData?['location'] ?? 'Não cadastrado'}',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => StartPage()),
                        );
                      },
                      child: const Text(
                          'Sair',
                        style: TextStyle(fontSize: 18),
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


