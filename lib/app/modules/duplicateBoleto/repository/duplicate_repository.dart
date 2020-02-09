import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:franet/app/BDHive/initHive.dart';

class DuplicateRepository extends Disposable {
  Dio dio = Dio();

  Future getFatura2Via() async {
    Response response;
    var box = await getHiveInstance();//await initHive();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    response = await dio.post(box.get("baseUrl") + "/fatura2via", data: {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato")
    });
    return response.data;
  }

  Future postFatura2Via(String tipo) async {
    Response response;
    var box = await getHiveInstance();//initHive();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    response = await dio.post(box.get("baseUrl") + "/fatura2via", data: {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato"),
      "tipo":tipo
    });
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
