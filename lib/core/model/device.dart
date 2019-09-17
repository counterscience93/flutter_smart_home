// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

class Device {
    String deviceId;
    String deviceName;
    int customerId;
    String dayActive;
    String dateAdded;
    bool deviceStatus;
    int categoryId;
    List<Slot> slot;

    Device({
        this.deviceId,
        this.deviceName,
        this.customerId,
        this.dayActive,
        this.dateAdded,
        this.deviceStatus,
        this.categoryId,
        this.slot,
    });

    factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Device.fromJson(Map<String, dynamic> json) => Device(
        deviceId: json["deviceId"] == null ? null : json["deviceId"],
        deviceName: json["deviceName"] == null ? null : json["deviceName"],
        customerId: json["customerId"] == null ? null : json["customerId"],
        dayActive: json["dayActive"] == null ? null : json["dayActive"],
        dateAdded: json["dateAdded"] == null ? null : json["dateAdded"],
        deviceStatus: json["deviceStatus"] == null ? null : json["deviceStatus"],
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        slot: json["slot"] == null ? null : List<Slot>.from(json["slot"].map((x) => Slot.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId == null ? null : deviceId,
        "deviceName": deviceName == null ? null : deviceName,
        "customerId": customerId == null ? null : customerId,
        "dayActive": dayActive == null ? null : dayActive,
        "dateAdded": dateAdded == null ? null : dateAdded,
        "deviceStatus": deviceStatus == null ? null : deviceStatus,
        "categoryId": categoryId == null ? null : categoryId,
        "slot": slot == null ? null : List<dynamic>.from(slot.map((x) => x.toJson())),
    };
}

class Slot {
    int index;
    String name;
    bool active;

    Slot({
        this.index,
        this.name,
        this.active,
    });

    factory Slot.fromRawJson(String str) => Slot.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        index: json["index"] == null ? null : json["index"],
        name: json["name"] == null ? null : json["name"],
        active: json["active"] == null ? null : json["active"],
    );

    Map<String, dynamic> toJson() => {
        "index": index == null ? null : index,
        "name": name == null ? null : name,
        "active": active == null ? null : active,
    };
}
