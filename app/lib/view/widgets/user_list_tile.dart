import 'package:flutter/material.dart';

import '../../model/user.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Center(
        child: Text('${user.name} ${user.surname}'),
      ),
    );
  }
}
