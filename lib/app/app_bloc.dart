import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/app_widget.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  Future getAndroidOrIOS() async {
    List deviceID = [];
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      await deviceInfo.androidInfo.then((onValue) {
      if (onValue != null) {
        deviceID.add(onValue.androidId);
        deviceID.add("android");
      }
    });
    } else if (Platform.isIOS) {
      await deviceInfo.iosInfo.then((onValue) {
      if (onValue != null) {
        deviceID.add(onValue.identifierForVendor);
        deviceID.add("ios");
      }
      });
    }
    return deviceID;
  }

  Future<void> initOneSignal() async {
    OneSignal.shared.init("220eaff6-dbb1-4793-9a20-114d67619362", iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    var deviceID = await getAndroidOrIOS();
    OneSignal.shared.setExternalUserId(deviceID[0]);
  }
  
  final BehaviorSubject<MaterialColor> _color = BehaviorSubject<MaterialColor>();
  Sink<MaterialColor> get inputColor => _color.sink;
  Stream get outputColor => _color.stream;

  alteraColor(var cor) {
    inputColor.add(alterColor(color: cor));
  }
  @override
  void dispose() {
    _color.close();
    super.dispose();
  }
}
