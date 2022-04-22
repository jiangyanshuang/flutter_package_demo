import 'dart:async';

import 'package:flutter/services.dart';

class Hahahaha {
  static const MethodChannel _channel = MethodChannel('hahahaha');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /*! @brief WWKApi的成员函数，向企业微信终端程序注册企业应用。
  *
  * 需要在每次启动第三方应用程序时调用。第一次调用后，会在企业微信的可用应用列表中出现。
  * @see registerApp
  * @param appid 企业微信开发者ID
  * @param corpid 企业微信企业ID
  * @param agentid 企业微信企业应用ID
  * @return 成功返回YES，失败返回NO。
  */
  static Future<bool> registerApp({required String appid, required String corpid, required String agentid}) async {
    final bool res = await _channel.invokeMethod('registerApp');
    return res;
  }
}





// flutter
// 暴露注册方法
// 点击企业微信登陆事件方法
// 监听企业微信授权回调结果

// ios
// 注册企业微信
// 调用企业微信登陆
// 企业微信返回后去触发flutter方法

// 插件使用说明书