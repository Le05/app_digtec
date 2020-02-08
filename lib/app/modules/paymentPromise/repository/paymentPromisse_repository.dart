import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class PaymentPromisseRepository extends Disposable {
  Dio dio = Dio();

  Future paymentPromiseRepository(
      String cpfcnpj, String senha, int contrato,String baseUrl) async {
    Response response;
    dio.clear();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 10000;
    response = await dio.post(baseUrl+"/promessapagamento",
        data: {"cpfcnpj": cpfcnpj, "senha": senha, "contrato": contrato});
      
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
