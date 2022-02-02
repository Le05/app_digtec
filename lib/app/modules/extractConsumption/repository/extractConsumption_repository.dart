import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';

class ExtractConsumptionRepository extends Disposable {

  Future buscarConsumo(String ano,String mes) async {
    Response response =
        await dio.post(box.get("baseUrl") + "/extratouso", data: {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato"),
      "ano": ano,
      "mes": mes
    });
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
