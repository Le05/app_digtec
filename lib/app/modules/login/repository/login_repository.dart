import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/models/ContractsModel.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';
import 'package:hive/hive.dart';

class LoginRepository extends Disposable {
  Map retornos = {};
  Future login(cpfCnpj, senha) async {
    int retorno;
    // resultados de retorno
    // 1 -> ocorreu um erro ao processar as requisições,ou manutenção
    // 0 -> ocorreu tudo certo, e existe mais de um contrato
    // 2 -> ocorreu tudo certo e existe um contrato só
    // 3 -> ocorreu tudo certo, porém nao existe nenhum contrato
    try {
      Response response;
      List<Contracts> contracts;
      Box box = await getHiveInstance(); //initHive();
      String baseUrl = "https://www.appdoprovedor.com.br/_api/verificaws.php";
      String deviceID = box.get("deviceID");
      String plataforma = box.get("plataforma");
      dio.clear();
      dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
      response = await dio.post(baseUrl, data: {
        "key": key,
        "token": token,
        "cpfcnpj": cpfCnpj,
        "senha": senha
      });
      baseUrl = response.data["ws"];
      await updateBaseUrl(response.data["ws"]);
      response = await dio.post(response.data['ws'] + "/contratos",
          data: {"cpfcnpj": cpfCnpj, "senha": senha});
      contracts = await fromJson(response.data["contratos"]);
      // existe mais de um contrato retorno(0)
      if (response.data["contratos"].length > 1) {
        /*await enviarDadosDispositivo(
            response.data["contratos"],
            "https://www.appdoprovedor.com.br/_api/write_dispositivo.php",
            deviceID,
            key,
            token,
            plataforma);*/
        retorno = 0;
      }
      // existe apenas um contrato retorno(2)
      if (response.data["contratos"].length == 1) {
        await enviarDadosDispositivo(
            response.data["contratos"],
            "https://www.appdoprovedor.com.br/_api/write_dispositivo.php",
            deviceID,
            key,
            token,
            plataforma);
        retorno = 2;
      }
      // nao existe nenhum contrato retorno(3)
      if (response.data["contratos"].length == 0) retorno = 3;
      // utilizar o write_dispositivo.php linha 103 do index.js do loginscreen
      //retorno = 0;
      retornos.addAll({"retorno": retorno, "contracts": contracts});
      return retornos;
    } catch (e) {
      print(e);
      retorno = 1;
      retornos.addAll({"retorno": retorno, "contracts": ""});
      return retornos;
    }
  }

  Future enviarDadosDispositivo(
      List contratos, String baseUrl, deviceID, key, token, plataforma) async {
    for (var contrato in contratos) {
      await dio.post(baseUrl, data: {
        "codAparelho": deviceID,
        "key": key,
        "token": token,
        "playerId": playerId,
        "contrato": contrato["contrato"],
        "plataforma": plataforma
      });
    }
  }

Future verificaInternet() async {
  dio.clear();
  await dio.get("https://www.google.com");
}
  //dispose will be called automatically
  @override
  void dispose() {}
}
