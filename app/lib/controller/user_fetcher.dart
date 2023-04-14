import 'package:app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFetcher {
  Future<List<User>> fetchUsers() async {
    return (await FirebaseFirestore.instance.collection('users').get())
        .docs
        .map((e) => User.fromJson(e.data()))
        .toList();
  }
}
