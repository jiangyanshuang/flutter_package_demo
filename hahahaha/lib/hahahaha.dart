import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Hahahaha {
  static const MethodChannel _channel = MethodChannel('hahahaha');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get getNative async {
    final String? res = await _channel.invokeMethod('getNative');
    return res;
  }

  static Future<String?> sayHello(String message) async {
    final Map<dynamic, dynamic>? res = await _channel.invokeMethod('sayHello', <String, dynamic>{'message': message});
    String? hehe = res!["info"];

    final StreamSubscription _eventSubscription =
        const EventChannel('flutter_plugin_event').receiveBroadcastStream().listen(
      (event) {
        final Map<dynamic, dynamic> map = event;

        switch (map['event']) {
          case 'DemoEvent':
            String value = map['value'];
            debugPrint('DemoEventData：$value');
            break;
          default:
        }
      },
      onError: (error) {
        debugPrint(error);

        throw error;
      },
    );

    return hehe;
  }

  // ---------------------------------------------------------------------

}
