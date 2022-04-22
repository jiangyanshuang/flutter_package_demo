#import "HahahahaPlugin.h"
#import "FlutterPluginEvent.h"
#import "WWKApi.h"

@implementation HahahahaPlugin

FlutterPluginEvent *pluginEvent;


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"hahahaha"
            binaryMessenger:[registrar messenger]];
  HahahahaPlugin* instance = [[HahahahaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];


  pluginEvent = [[FlutterPluginEvent alloc] init];
  pluginEvent.eventChannel = [FlutterEventChannel
                                eventChannelWithName:@"flutter_plugin_event"
                                binaryMessenger:[registrar messenger]];
  [pluginEvent.eventChannel setStreamHandler:pluginEvent];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"registerApp" isEqualToString:call.method]) {
    
    NSString *appid = call.arguments[@"appid"];
    NSString *corpid = call.arguments[@"corpid"];
    NSString *agentid = call.arguments[@"agentid"];

    BOOL res = [WWKApi registerApp:appid corpId:corpid agentId:agentid];
    result(@(res));

  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
