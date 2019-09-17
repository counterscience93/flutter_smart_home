import 'dart:convert';

import 'package:smart_home_final/core/model/user.dart';
import 'package:smart_home_final/core/model/device.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  static const endpoint =
      'http://my-json-server.typicode.com/leman7193/fake_json';

  var client = new http.Client();

  Future<User> getUserById(int userId) async {
    // Get user profile for id
    var response = await client.get('$endpoint/users/$userId');
    // check response.statusCode == 200 do ...
    print('BODYYYY: ${response.body}');
    // Convert and return
    return User.fromRawJson(response.body);
  }

  Future<List<Device>> getDevicesByUserId(int userId) async {
    var devices = List<Device>();
    print('URI: $endpoint/devices?userId=$userId');
    // Get list devices by user id
    var response = await client.get('$endpoint/devices?userId=$userId');

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;
    print('PARSED: ${parsed.toString()}');
    // loop and convert each item to Device
    // devices = List<Device>.from(parsed.map((x) => Device.fromRawJson(x.toString())));
    for (var device in parsed) {
      print('DEVICEEEEE: ${device.toString()}');
      devices.add(Device.fromJson(device));
    }
    print('DEVICES: ${devices.length}');
    return devices;
  }
}
