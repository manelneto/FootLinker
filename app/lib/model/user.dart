class User {
  final String name;
  final String surname;

  User({
    required this.name,
    required this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
    );
  }

  void show() {
    print('USER name: $name surname $surname\n');
  }
}
