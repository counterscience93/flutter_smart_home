import 'dart:convert';

class Device {
    int deviceId;
    String deviceName;
    int customerId;
    String dayActive;
    String dateAdded;
    bool deviceStatus;
    int categoryId;

    Device({
        this.deviceId,
        this.deviceName,
        this.customerId,
        this.dayActive,
        this.dateAdded,
        this.deviceStatus,
        this.categoryId,
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
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId == null ? null : deviceId,
        "deviceName": deviceName == null ? null : deviceName,
        "customerId": customerId == null ? null : customerId,
        "dayActive": dayActive == null ? null : dayActive,
        "dateAdded": dateAdded == null ? null : dateAdded,
        "deviceStatus": deviceStatus == null ? null : deviceStatus,
        "categoryId": categoryId == null ? null : categoryId,
    };
}
