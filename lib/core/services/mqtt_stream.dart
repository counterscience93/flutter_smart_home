import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

class AppMqttTransactions {
  Logger log;
// Constructor
  AppMqttTransactions() {
    // Start logger.  MAKE SURE STRING IS NAME OF DART FILE WHERE
    // CODE IS (in this case the filename is mqtt_stream.dart)
    // TBD: I could not find a way to get the API to return the filename.
    log = Logger('mqtt_stream.dart');
  }
  MqttClient client;
  //
  // The caller could call subscribe many times.  Then many subscriptions would be available.
  // in some situations, this will make sense.  For now I limit to one subscription at a time.
  String previousTopic;
  bool bAlreadySubscribed = false;

  Future<bool> connect() async {
    _connectToClient();
  }
//////////////////////////////////////////
// Subscribe to an (Adafruit) mqtt topic.
  Future<bool> subscribe(String topic) async {
    // With await, we are assured of getting a string back and not a
    // Future<String> placeholder instance.
    // The rest of the code in the Main UI thread can continue.
    // I liked the explanation in the "Dart & Flutter Asnchronous Tutorial.."
    // https://bit.ly/2Dq12PJ
    //
    if (await _connectToClient() == true) {
      /// Add the unsolicited disconnection callback
      client.onDisconnected = _onDisconnected;

      /// Add the successful connection callback
      client.onConnected = _onConnected;

      /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
      /// You can add these before connection or change them dynamically after connection if
      /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
      /// can fail either because you have tried to subscribe to an invalid topic or the broker
      /// rejects the subscribe request.
      client.onSubscribed = _onSubscribed;
      _subscribe(topic);
    }
    return true;
  }

//
// Connect to Adafruit io
//
  Future<bool> _connectToClient() async {
    if (client != null &&
        client.connectionStatus.state == MqttConnectionState.connected) {
      log.info('already logged in');
    } else {
      client = await _login();
      if (client == null) {
        return false;
      }
    }
    return true;
  }

  /// The subscribed callback
  void _onSubscribed(String topic) {
    log.info('Subscription confirmed for topic $topic');
    this.bAlreadySubscribed = true;
    this.previousTopic = topic;
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    log.info('OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      log.info(':OnDisconnected callback is solicited, this is correct');
    }
    client.disconnect();
  }

  void _onConnected() {
    log.info('OnConnected client callback - Client connection was sucessful');
  }

  Future<Map> _getBrokerAndKey() async {
    // TODO: Check if private.json does not exist or expected key/values are not there.
    String connect = await rootBundle.loadString('config/private.json');
    return (json.decode(connect));
  }

  //
  // login to Adafruit
  //
  Future<MqttClient> _login() async {

    Map connectJson = await _getBrokerAndKey();
    // TBD Test valid broker and key
    log.info('in _login....broker  : ${connectJson['broker']}');
    log.info('in _login....port     : ${connectJson['port']}');
    log.info('in _login....clientId     : ${connectJson['clientId']}');
    log.info('in _login....username: ${connectJson['username']}');

    client = MqttClient(connectJson['broker'], connectJson['key']);
    // Turn on mqtt package's logging while in test.
    client.logging(on: true);
    final MqttConnectMessage connMess = MqttConnectMessage()
        .authenticateAs(connectJson['username'], '123456')
        .withClientIdentifier('myClientID')
        .keepAliveFor(60) // Must agree with the keep alive set above or not set
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.exactlyOnce);
    log.info('Mobile client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however eill
    /// never send malformed messages.
    try {
      await client.connect();
    } on Exception catch (e) {
      log.severe('EXCEPTION::client exception - $e');
      client.disconnect();
      client = null;
      return client;
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      log.info('Adafruit client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      log.info(
          'Adafruit client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      client = null;
    }
    return client;
  }

//
// Subscribe to the readings being published into Adafruit's mqtt by the energy monitor(s).
//
  Future _subscribe(String topic) async {
    // for now hardcoding the topic
    if (this.bAlreadySubscribed == true) {
      client.unsubscribe(this.previousTopic);
    }
    log.info('Subscribing to the topic $topic');
    client.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      /// The payload is a byte buffer, this will be specific to the topic
      // TODO: AdafruitFeed.add(pt);
      log.info(
          'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      return pt;
    });
  }

//////////////////////////////////////////
// Publish to an (Adafruit) mqtt topic.
  Future<void> publish(String topic, String value) async {
    // Connect to the client if we haven't already
    if (await _connectToClient() == true) {
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(value);
      client.publishMessage(topic, MqttQos.atMostOnce, builder.payload);
    }
  }
}
