import 'package:flutter/services.dart';

const platform = MethodChannel('eng.smaho.com/esptouch_plugin/example');

/// GET wifi SSID
/// return null if BSSID information is not available
Future<String> get ssid async {
  String result;
  try {
    result = await platform.invokeMethod('ssid');
    return result;
  } on PlatformException catch (e) {
    result = "failed to get wifi info: '${e.message}'.";
  }
  return result;
}

/// GET wifi bssid
/// return null if BSSID information is not available
Future<String> get bssid async {
  String result;
  try {
    result = await platform.invokeMethod('bssid');
    return result;
  } on PlatformException catch (e) {
    result = "failed to get bssid wifi info: '${e.message}'.";
  }
  return result;
}