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
                  //注册企业微信
                  String appid = "wwauth50291a264ed6e2c0000019";
                  String corpid = "wx50291a264ed6e2c0";
                  String agentid = "1000019";

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
