import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:franet/app/BDHive/initHive.dart';

class InvoicesRepository extends Disposable {
  Dio dio = Dio();
  Response response;
  Future getInvoicesRepository(
      String cpfcnpj, String senha, int contrato, String baseUrl) async {
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    response = await dio.post(baseUrl + "/titulos",
        data: {"cpfcnpj": cpfcnpj, "senha": senha, "contrato": contrato});
    return response.data["faturas"];
  }

  Future generateCodigoPix(int id, String cpfcnpj, String senha, int contrato,
      String baseUrl) async {
    return await dio.post(baseUrl + '/pagamento/pix/$id',data: {
      "cpfcnpj": cpfcnpj, "senha": senha, "contrato": contrato
    }).then((value) => value.data);
  }

    Future buscarGatewayPagamento(
      int id, String cpfcnpj, String senha, int contrato) async {
    return await dio.post(box.get("baseUrl") + "/pagamento/checkout/$id/cartao",
        data: {
          "cpfcnpj": cpfcnpj,
          "senha": senha,
          "contrato": contrato
        }).then((value) => value);
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
