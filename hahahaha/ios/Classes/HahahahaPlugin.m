#import "HahahahaPlugin.h"
#import "FlutterPluginEvent.h"
#import "FluwxResponseHandler.h"
#import "WWKApi.h"

@implementation HahahahaPlugin

FlutterPluginEvent *pluginEvent;


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"hahahaha"
            binaryMessenger:[registrar messenger]];
  HahahahaPlugin* instance = [[HahahahaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar addApplicationDelegate:instance];
  [[FluwxResponseHandler defaultManager] setMethodChannel:channel];


  pluginEvent = [[FlutterPluginEvent alloc] init];
  pluginEvent.eventChannel = [FlutterEventChannel
                                eventChannelWithName:@"flutter_plugin_event"
                                binaryMessenger:[registrar messenger]];
  [pluginEvent.eventChannel setStreamHandler:pluginEvent];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"wx_registerApp" isEqualToString:call.method]) {
    
    NSString *appid = call.arguments[@"appid"];
    NSString *corpid = call.arguments[@"corpid"];
    NSString *agentid = call.arguments[@"agentid"];

    BOOL res = [WWKApi registerApp:appid corpId:corpid agentId:agentid];
    result(@(res));

  }else if ([@"wx_sendReq" isEqualToString:call.method]) {

    WWKSSOReq *req = [[WWKSSOReq alloc] init];
    req.state = @"jkk500-qywx-login";
    BOOL res = [WWKApi sendReq:req];
    result(@(res));

  } else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark - AppDelegate

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WWKApi handleOpenURL:url delegate:[FluwxResponseHandler defaultManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WWKApi handleOpenURL:url delegate:[FluwxResponseHandler defaultManager]];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    return [WWKApi handleOpenURL:url delegate:[FluwxResponseHandler defaultManager]];
}

@end
