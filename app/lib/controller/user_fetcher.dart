import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserFetcher {
  Future<List<User>> fetchUsers() async {
    return (await FirebaseFirestore.instance.collection('users').get())
        .docs
        .map((e) => User.fromJson(e.data()))
        .toList();
  }
}
