import 'package:meta/meta.dart';
import 'package:smart_home_final/core/model/device.dart';
import 'package:smart_home_final/core/services/api.dart';

import '../base_model.dart';

class DevicesModel extends BaseModel {
  Api _api;

  DevicesModel({
    @required Api api,
  }) : _api = api;

  List<Device> devices;

  Future getDevices(int userId) async {
    setBusy(true);
    devices = await _api.getDevicesByUserId(userId);
    setBusy(false);
  }
}
