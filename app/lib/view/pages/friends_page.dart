import 'package:app/controller/user_fetcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = UserFetcher().fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
      ),
    );
  }
}