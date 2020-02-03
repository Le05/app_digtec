import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class InvoicesRepository extends Disposable {
  Dio dio = Dio();
  Response response;
  Future getInvoicesRepository(
      String cpfcnpj, String senha, int contrato, String baseUrl) async {
    dio.clear();
    response = await dio.post(baseUrl + "/titulos",
        data: {"cpfcnpj": cpfcnpj, "senha": senha, "contrato": contrato});
        return response.data["faturas"];
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
