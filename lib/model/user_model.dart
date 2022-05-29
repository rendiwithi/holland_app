class User {
  int id;
  String username;
  String password;
  String name;
  String role;
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.role,
  });
}

List<User> listUser = [
  User(
    id: 1,
    username: "admin",
    password: "admin",
    name: "Diaz",
    role: "admin",
  ),
  User(
      id: 2,
      username: "user",
      password: "user1234",
      name: "User Test",
      role: "user"),
];
