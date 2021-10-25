import 'dart:convert';
import 'dart:io';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:device_info/device_info.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';

class AppBloc extends BlocBase {
  Future getAndroidOrIOS() async {
    if (base64.encode(utf8.encode(key + token)) != cripto)
          token = cripto;

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

  Future<void> initOneSignal(String keyOneSignal) async {
    OneSignal.shared.setAppId(keyOneSignal);
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.promptUserForPushNotificationPermission();
    OneSignal.shared.promptLocationPermission();
    // OneSignal.shared.init(keyOneSignal, iOSSettings: {
    //   OSiOSSettings.autoPrompt: true,
    //   OSiOSSettings.inAppLaunchUrl: true
    // });
    var deviceID = await getAndroidOrIOS();
    OneSignal.shared.setExternalUserId(deviceID[0]);
    var status = await OneSignal.shared.getDeviceState();
    playerId = status.userId;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
