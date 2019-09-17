import 'dart:convert';

class User {
    int userId;
    String userName;
    String phone;
    String email;
    String token;
    String address;
    bool active;

    User({
        this.userId,
        this.userName,
        this.phone,
        this.email,
        this.token,
        this.address,
        this.active,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        userName: json["userName"],
        phone: json["phone"],
        email: json["email"],
        token: json["token"],
        address: json["address"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "phone": phone,
        "email": email,
        "token": token,
        "address": address,
        "active": active,
    };
}
