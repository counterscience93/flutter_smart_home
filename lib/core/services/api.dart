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
    // Convert and return
    return User.fromRawJson(response.body);
  }

  Future<List<Device>> getDevicesByUserId(int userId) async {
    var devices = List<Device>();
    print('URI: $endpoint/devices?userId=$userId');
    // Get list devices by user id
    var response = await client.get('$endpoint/devices?userId=$userId');

    // parse into List
    var parsed = json.decode(response.body) as List<String>;

    // loop and convert each item to Post
    for (var device in parsed) {
      devices.add(Device.fromRawJson(device));
    }

    return devices;
  }
  
}
