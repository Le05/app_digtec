import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:franet/app/BDHive/initHive.dart';

class ExtractConsumptionRepository extends Disposable {
  Dio dio = Dio();

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
