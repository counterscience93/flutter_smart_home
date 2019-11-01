package com.example.smart_home_final

import android.content.Context
import android.net.wifi.WifiManager
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "com.khn.smarthome/esptouch"


  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler{call ,result ->
      if(call.method == "ssid"){
        val wifiManager: WifiManager
        get() = getSystemService(Context.WIFI_SERVICE) as WifiManager
      }
    }
  }
}
