import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef VoidCallback = void Function(Map<String, String>);

class Hahahaha {
  static const MethodChannel _channel = MethodChannel('hahahaha');

  /*! @brief WWKApi的成员函数，向企业微信终端程序注册企业应用。
  *
  * 需要在每次启动第三方应用程序时调用。第一次调用后，会在企业微信的可用应用列表中出现。
  * @see registerApp
  * @param appid 企业微信开发者ID
  * @param corpid 企业微信企业ID
  * @param agentid 企业微信企业应用ID
  * @return 成功返回YES，失败返回NO。
  */
  static void registerApp({required String appid, required String corpid, required String agentid}) async {
    _channel.invokeMethod('wx_registerApp', <String, String>{'appid': appid, 'corpid': corpid, 'agentid': agentid});
  }

/*! @brief 发送请求到企业微信，等待企业微信返回onResp
 *
 * 函数调用后，会切换到企业微信的界面。第三方应用程序等待企业微信返回onResp。企业微信在异步处理完成后一定会调用onResp。支持以下类型
 * WWKSendMessageReq等。
 * @param req 具体的发送请求，在调用函数后，请自己释放。
 * @return 成功返回YES，失败返回NO。
 */

  static Future<Map<String, String>> sendReq() async {
    final Completer<Map<String, String>> completer = Completer();

    _channel.invokeMethod('wx_sendReq');

    _channel.setMethodCallHandler((call) async {
      debugPrint("===授权结果===");
      debugPrint("===method===${call.method}");
      debugPrint("===arguments===${call.arguments}");

      switch (call.method) {
        case "onAuthResponse":
          completer.complete({"state": call.arguments["state"], "code": call.arguments["code"]});
      }
    });
    return completer.future;
  }
}
