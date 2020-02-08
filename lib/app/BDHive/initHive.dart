import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/app_bloc.dart';
import 'package:franet/app/modules/maintenance/maintenance_module.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box box;
AppBloc appBloc = AppBloc();
Dio dio = Dio();
Response response;
Future<Box> initHive({BuildContext context}) async {
  String cor;
  // tenta abrir, caso de erro, ele inicializa e tenta abrir denovo
  try {
    box = await Hive.openBox('Configs');
  } catch (e) {
    var link;
    var resposta = await getParams();
    if(resposta[0]["param_status"] == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceModule()));
    }
    cor = resposta[0]["param_corapp"];
    cor = cor.replaceFirst("#", "");
    appBloc.alteraColor(int.parse(cor,radix: 16));
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
      box.put("param_corapp", resposta[0]["param_corapp"]);
      box.put("param_senha", resposta[0]["param_senha"]);
      box.put("param_senhapadrao", resposta[0]["param_senhapadrao"]);
      box.put("param_propaganda", resposta[0]["param_propaganda"]);
      box.put("param_system", resposta[0]["param_system"]);
      if(box.containsKey("param_logotipo")){
        link = box.get("param_logotipo");
        if(link != resposta[0]["param_logotipo"]){
          box.put("param_logotipo", resposta[0]["param_logotipo"]);
        }
      }
      else
        box.put("param_logotipo", resposta[0]["param_logotipo"]);
    }
  }
  //await Future.delayed(Duration(seconds: 3));

  return box;
}

Future getParams() async {
  try {
   dio.clear();
  response = await dio.post(
      "https://www.appdoprovedor.com.br/_api/read_app-new.php",
      data: {"key": "franet", "token": "7K74P-LBSB3-XYJXA-G6MQS"}); 
  return response.data;
  } catch (e) {
    return [];
  }
}

Future<Box> getHiveInstance() async {
  if (box.isOpen)
    return box;
  else {
    box = await initHive();
    return box;
  }
}

Future updateBaseUrl(String baseUrl) async {
  Box box = await initHive();
  box.put("baseUrl", baseUrl);
}
