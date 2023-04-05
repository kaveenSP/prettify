// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.name,
        required this.password,
        required this.email,
    });

    String name;
    String password;
    String email;

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        password: json["password"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "email": email,
    };
}