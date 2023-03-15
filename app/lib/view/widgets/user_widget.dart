import 'package:flutter/material.dart';

import '../../model/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text('${user.name} ${user.surname}'),
    );
  }
}
