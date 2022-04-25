import 'package:flutter/material.dart';
import 'package:hahahaha/hahahaha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  // appid 企业微信开发者ID
                  // corpid 企业微信企业ID
                  // agentid 企业微信企业应用ID
                  String appid = "xxx";
                  String corpid = "xxx";
                  String agentid = "xxx";
                  // 注册企业微信
                  Hahahaha.registerApp(appid: appid, corpid: corpid, agentid: agentid);
                },
                child: const Text("注册"),
              ),
              TextButton(
                onPressed: () async {
                  Map map = await Hahahaha.sendReq();
                  debugPrint(map.toString());
                },
                child: const Text("登陆"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
