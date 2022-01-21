class User {
  String username, email, role, password, gender;
  String date;
  String? id;

  User(
      {this.id,
      required this.username,
      required this.email,
      required this.role,
      required this.password,
      required this.gender,
      required this.date});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      password: json['password'],
      gender: json['gender'],
      date: json['date'],
    );
  }
}
