import 'package:smart_home_final/core/model/device.dart';
// import 'package:smart_home_final/core/model/slot.dart';
import 'package:smart_home_final/core/services/api.dart';

import '../base_model.dart';

class DeviceModel extends BaseModel {

  DeviceModel(this.device);

  Device device;

  // Future getDevice(String deviceId) async {
  //   setBusy(true);
  //   setBusy(false);
  // }
  // Future updateDeviceModel(Slot slot) async {
  //   setBusy(true);
  //   device.slots[slot.index] = slot;
  //   setBusy(false);
  // }

}
