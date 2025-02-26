class User {
  final int userId;
  final String email;
  final String password;
  final String name;
  final int age;
  final String gender;

  User({
    required this.userId,
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? 0,
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
    );
}

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'password': password,
      'name': name,
      'age': age,
      'gender': gender,
    };
  }
}