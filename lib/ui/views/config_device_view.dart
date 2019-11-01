import 'dart:async';

import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home_final/src/model/wifi_info.dart';

class ConfigDevice extends StatefulWidget {
  ConfigDevice({Key key}) : super(key: key);

  @override
  _ConfigDeviceState createState() => _ConfigDeviceState();
}

const helperSSID =
    'SSID is the technical term for a network name. When you set up a wireless home network, you give it a name to distinguish it from other networks in your  neighebourhood.';
const helperBSSID =
    'BSSID is the MAC address of the wireless access point (router).';
const helperPassword = "The password of the WIFI network";

class _ConfigDeviceState extends State<ConfigDevice> {
  final TextEditingController _ssid = TextEditingController();
  final TextEditingController _bssid = TextEditingController();
  final TextEditingController _password = TextEditingController();

  ESPTouchPacket _packet = ESPTouchPacket.broadcast;

  @override
  void dispose() {
    _ssid.dispose();
    _bssid.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new Device',
          style: TextStyle(
            fontFamily: 'serif-monospace',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: form(context),
          );
        },
      ),
    );
  }

  bool fetchingWifiInfo = false;
  void fetchWifiInfo() async {
    setState(() {
      fetchingWifiInfo = true;
    });
    try {
      //get wifi info from wifi_info.dart
      _ssid.text = await ssid;
      _bssid.text = await bssid;
    } finally {
      setState(() {
        fetchingWifiInfo = false;
      });
    }
  }

  createTask(){
    return ESPTouchTask(
      ssid: _ssid.text,
      bssid: _bssid.text,
      password: _password.text,
      packet: _packet
    );
  }

  Widget form(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Form(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          Center(
            child: OutlineButton(
              highlightColor: Colors.transparent,
              highlightedBorderColor: color,
              onPressed: fetchingWifiInfo ? null : fetchWifiInfo,
              child: fetchingWifiInfo
                  ? Text(
                      'Fetching Wifi info',
                      style: TextStyle(color: Colors.grey),
                    )
                  : Text(
                      'Use current WiFi',
                      style: TextStyle(color: color),
                    ),
            ),
          ),
          TextFormField(
            controller: _ssid,
            decoration: InputDecoration(
                labelText: 'SSID',
                hintText: 'Name of wifi',
                helperText: helperSSID),
          ),
          TextFormField(
            controller: _bssid,
            decoration: InputDecoration(
                labelText: 'BSSID',
                hintText: 'Mac address Wifi',
                helperText: helperBSSID),
          ),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password of wifi',
                helperText: helperPassword),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskRoute(task: createTask(),),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TaskRoute extends StatefulWidget {
  final ESPTouchTask task;
  TaskRoute({this.task});
  @override
  _TaskRouteState createState() => _TaskRouteState();
}

class _TaskRouteState extends State<TaskRoute> {
  Stream<ESPTouchResult> _stream;
  StreamSubscription<ESPTouchResult> _streamSubscription;

  @override
  void initState() {
    _stream = widget.task.execute();
    _streamSubscription = _stream.listen((value) {
      print('Receive value in TaskROuteState $value');
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Widget waitingState(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 16,
          ),
          Text('Waiting for results'),
        ],
      ),
    );
  }

  Widget error(BuildContext context, String s) {
    return Center(
      child: Text(
        s,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  copyValue(BuildContext context, String label, String v) {
    return () {
      Clipboard.setData(ClipboardData(text: v));
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Copied $label to clipboard: $v'),
      ));
    };
  }

  Widget noneState(BuildContext context) {
    return Text('none');
  }

  Widget resultList(BuildContext context) {
    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (_, index) {
        final result = _results.toList(growable: false)[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onLongPress: copyValue(context, 'BSSID', result.bssid),
                child: Row(
                  children: <Widget>[
                    Text('BSSID: ', style: Theme.of(context).textTheme.body2),
                    Text(result.bssid,
                        style: TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              ),
              GestureDetector(
                onLongPress: copyValue(context, 'IP', result.ip),
                child: Row(
                  children: <Widget>[
                    Text('IP: ', style: Theme.of(context).textTheme.body2),
                    Text(result.ip, style: TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  final Set<ESPTouchResult> _results = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
      ),
      body: Container(
        child: StreamBuilder<ESPTouchResult>(
          builder: (context, AsyncSnapshot<ESPTouchResult> snapshot) {
            if (snapshot.hasError) {
              return error(context, 'Error in StreamBuilder');
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                _results.add(snapshot.data);
                return resultList(context);
              case ConnectionState.none:
                return noneState(context);
              case ConnectionState.done:
                return resultList(context);
              case ConnectionState.waiting:
                return waitingState(context);
            }
          },
          stream: _stream,
        ),
      ),
    );
  }
}
