package com.example.hahahaha;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** HahahahaPlugin */
public class HahahahaPlugin implements FlutterPlugin, MethodCallHandler {

  //事件派发对象
  private EventChannel.EventSink eventSink = null;
  //事件派发流
  private EventChannel.StreamHandler streamHandler = new EventChannel.StreamHandler(){
    @Override
    public void onListen(Objct o, EventChannel.EventSink sink){
      eventSink = sink;
    }

    @Override
    public void onCancel(Objct o) {
      eventSink = null;
    }
  };

  private FlutterPlugin(Registrar Registrar, MethodChannel channel) {
    //初始化事件
    // EventChannel eventChannel = new EventChannel(Registrar.messenger(),name:"flutter_plugin_event");
    // eventChannel.setStreamHandler(streamHandler);
  }



  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "hahahaha");
    channel.setMethodCallHandler(this);

    // FlutterPlugin()
    
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("sayHello")) {
      String message = cell.argument("message");
      String info = cell.argument("info");


      // 派发事件
      if(eventSink != null) {
        // eventSink.success({'event':'DemoEvent','value':'value is 10'});
      }


    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}

