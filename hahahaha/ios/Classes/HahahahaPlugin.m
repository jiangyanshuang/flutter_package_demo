#import "HahahahaPlugin.h"
#import "FlutterPluginEvent.h"


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
  }else if ([@"getNative" isEqualToString:call.method]) {
    result(@"iOS getNative");
  }else if ([@"sayHello" isEqualToString:call.method]) {
    result(@{@"sayHello":call.arguments[@"message"],@"info":@"哈哈info"});
    FlutterEventSink eventSink = pluginEvent.eventSink;
    if(eventSink){
      eventSink(@{@"event" : @"DemoEvent",@"value" : @"ios value is 10",});
    }

  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
