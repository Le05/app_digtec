import 'dart:io';
import 'package:franet/app/app_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<Box> initHive() async {
  Box box;
  AppBloc appBloc = AppBloc();
  // tenta abrir, caso de erro, ele inicializa e tenta abrir denovo
  try {
    box = await Hive.openBox('Configs');
  } catch (e) {
    if (e.message ==
        "You need to initialize Hive or provide a path to store the box.") {
      var deviceInfo = await appBloc.getAndroidOrIOS();
      Directory path = await getApplicationDocumentsDirectory();
      Hive.init(path.path);
      box = await Hive.openBox('Configs');
      box.put("plataforma", deviceInfo[1]);
      box.put("deviceID", deviceInfo[0]);
      box.put("token", "7K74P-LBSB3-XYJXA-G6MQS");
      box.put("key", "franet");
      box.put(
          "baseUrl", "https://www.appdoprovedor.com.br/_api/verificaws.php");
    }
  }
  await Future.delayed(Duration(seconds: 3));
  return box;
}

Future updateBaseUrl(String baseUrl) async {
  Box box = await initHive();
  box.put("baseUrl", baseUrl);
}
