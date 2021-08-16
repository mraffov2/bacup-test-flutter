// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok,
    this.message,
    this.user,
    this.token,
  });

  bool ok;
  String message;
  User user;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"] == null ? null : json["ok"],
        message: json["message"] == null ? null : json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok == null ? null : ok,
        "message": message == null ? null : message,
        "user": user == null ? null : user.toJson(),
        "token": token == null ? null : token,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.yearOld,
    this.user,
    this.registeredAt,
  });

  String id;
  String name;
  String email;
  int yearOld;
  String user;
  DateTime registeredAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        yearOld: json["year_old"] == null ? null : json["year_old"],
        user: json["user"] == null ? null : json["user"],
        registeredAt: json["registeredAt"] == null
            ? null
            : DateTime.parse(json["registeredAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "year_old": yearOld == null ? null : yearOld,
        "user": user == null ? null : user,
        "registeredAt":
            registeredAt == null ? null : registeredAt.toIso8601String(),
      };
}
