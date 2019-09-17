import 'dart:convert';

class Category {
    int categoryId;
    String categoryName;
    String dateAdded;
    int userAdded;
    int userUpdate;
    String timeUpdate;
    bool active;

    Category({
        this.categoryId,
        this.categoryName,
        this.dateAdded,
        this.userAdded,
        this.userUpdate,
        this.timeUpdate,
        this.active,
    });

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        categoryName: json["categoryName"] == null ? null : json["categoryName"],
        dateAdded: json["dateAdded"] == null ? null : json["dateAdded"],
        userAdded: json["userAdded"] == null ? null : json["userAdded"],
        userUpdate: json["userUpdate"] == null ? null : json["userUpdate"],
        timeUpdate: json["timeUpdate"] == null ? null : json["timeUpdate"],
        active: json["active"] == null ? null : json["active"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId == null ? null : categoryId,
        "categoryName": categoryName == null ? null : categoryName,
        "dateAdded": dateAdded == null ? null : dateAdded,
        "userAdded": userAdded == null ? null : userAdded,
        "userUpdate": userUpdate == null ? null : userUpdate,
        "timeUpdate": timeUpdate == null ? null : timeUpdate,
        "active": active == null ? null : active,
    };
}
