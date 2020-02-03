import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:device_info/device_info.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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

  @override
  void dispose() {
    super.dispose();
  }
}
