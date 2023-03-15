import 'package:app/controller/user_fetcher.dart';
import 'package:app/view/widgets/user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late Future<List<User>> friends;

  @override
  void initState() {
    super.initState();
    friends = UserFetcher().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(child: Text('Amigos')),
        Center(
          child: FutureBuilder<List<User>>(
              future: friends,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserWidget(user: snapshot.data![index]);
                      },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }
              ),
        ),
      ],
    );
  }
}