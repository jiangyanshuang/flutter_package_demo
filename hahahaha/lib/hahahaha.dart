import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef VoidCallback = void Function(Map<String, String>);

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
    final bool res = await _channel
        .invokeMethod('wx_registerApp', <String, String>{'appid': appid, 'corpid': corpid, 'agentid': agentid});
    return res;
  }

/*! @brief 发送请求到企业微信，等待企业微信返回onResp
 *
 * 函数调用后，会切换到企业微信的界面。第三方应用程序等待企业微信返回onResp。企业微信在异步处理完成后一定会调用onResp。支持以下类型
 * WWKSendMessageReq等。
 * @param req 具体的发送请求，在调用函数后，请自己释放。
 * @return 成功返回YES，失败返回NO。
 */

  static void sendReq({required VoidCallback fun}) async {
    _channel.invokeMethod('wx_sendReq');

    _channel.setMethodCallHandler((call) async {
      debugPrint("===回到===${call.toString()}");

      switch (call.method) {
        case "onAuthResponse":
          fun(call.arguments);

          debugPrint("===反悔了===");
      }
    });
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

// ## 兼容Android 11
// 请在你的应用的`AndroidManifest.xml`中添加以下queries:

// ```xml
// <queries>
//     <intent>
//         <action android:name="${applicationId}.FlutterActivity" />
//     </intent>
// <intent>
//     <action android:name="android.intent.action.VIEW" />
//     <data
//         android:host="${applicationId}"
//         android:path="/"
//         android:scheme="wechatextmsg" />
// </intent>
// </queries>
// ```

// ## IOS
// 请在你的`AppDelegate`中主动注册`WXApi`
// ```oc
// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//     //向微信注册
// [[FluwxDelegate defaultManager] registerWxAPI:@"" universalLink:@""];
//     return YES;
// }
// ```
