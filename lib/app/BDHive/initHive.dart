import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:franet/app/app_bloc.dart';
import 'package:franet/app/modules/maintenance/maintenance_module.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box box;
AppBloc appBloc = AppBloc();
Dio dio = Dio();
Response response;
Future<Map> initHive({BuildContext context}) async {
  String cor;
  // tenta abrir, caso de erro, ele inicializa e tenta abrir denovo
  try {
    box = await Hive.openBox('Configs');
  } catch (e) {
    var link;
    var resposta = await getParams();
    if (resposta[0]["param_status"] == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MaintenanceModule()));
    }
    cor = resposta[0]["param_corapp"];
    cor = cor.replaceFirst("#", "");
    cor = "0xFF" + cor;
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
      box.put("contracts", null);
      box.put("param_corapp", resposta[0]["param_corapp"]);
      box.put("param_senha", resposta[0]["param_senha"]);
      box.put("param_senhapadrao", resposta[0]["param_senhapadrao"]);
      box.put("param_propaganda", resposta[0]["param_propagandas"]["param_propaganda"]);
      box.put("param_propagandaposicao", resposta[0]["param_propagandas"]["param_propagandaposicao"]);
      box.put("param_propagandatitulo", resposta[0]["param_propagandas"]["param_propagandatitulo"]);
      box.put("param_system", resposta[0]["param_system"]);
      box.put("param_txtaberturaos", resposta[0]["param_txtaberturaos"]);
      box.put("param_telprincipal", resposta[0]["param_telefones"]["param_telprincipal"]);
      box.put("param_telsecundario", resposta[0]["param_telefones"]["param_telsecundario"]);
      box.put("param_telwhats", resposta[0]["param_telefones"]["param_telwhats"]);
      box.put("param_txtpromessapag",resposta[0]["param_txtpromessapag"]);
      box.put("param_txtpromessapagok",resposta[0]["param_txtpromessapagok"]);
      box.put("param_facebook",resposta[0]["param_facebook"]);
      box.put("param_instagram",resposta[0]["param_instagram"]);
      if (box.containsKey("param_logotipo")) {
        link = box.get("param_logotipo");
        var linkParam = resposta[0]["param_logotipo"]; 
        if (link != linkParam) {
          box.put("param_logotipo", resposta[0]["param_logotipo"]);
          await DefaultCacheManager().downloadFile(resposta[0]["param_logotipo"]);
        }
      } else{
          box.put("param_logotipo", resposta[0]["param_logotipo"]);
          await DefaultCacheManager().downloadFile(resposta[0]["param_logotipo"]);
      }
        
    }
  }
  //cor = "0xFF0047AB";
  Map retorno = {"box": box, "color": alterColor(color: int.parse(cor))};
  return retorno;
}

Future getParams() async {
  try {
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
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
    var boxInit = await initHive();
    return boxInit["box"];
  }
}

Future updateBaseUrl(String baseUrl) async {
  Box box = await getHiveInstance();
  box.put("baseUrl", baseUrl);
}

alterColor({var color}) {
  int _cPrimaryValue = color;
  MaterialColor primary = MaterialColor(
    _cPrimaryValue,
    <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(_cPrimaryValue),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    },
  );
  return primary;
}
