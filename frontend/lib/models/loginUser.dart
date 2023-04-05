// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
    LoginUser({
        required this.name,
        required this.password,
    });

    String name;
    String password;

    factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        name: json["name"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
    };
}
