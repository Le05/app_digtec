import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:franet/app/BDHive/initHive.dart';

class PaymentCreditCardRepository extends Disposable {
  Dio dio = Dio();

  Future buscarCartoes() async {
    Response response = await dio.post(box.get("baseUrl") + '/cartao/list', data: {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato")
    });
    return response.data;
  }

Future cadastrarCartao(int fatura,String numero,String nome,String cvv,String email,bool salvarCartao) async{
    Response response = await dio.post(box.get("baseUrl") + '/pagamento/cartao/$fatura', data: {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato")
    });
    return response.data;
}
  //dispose will be called automatically
  @override
  void dispose() {}
}
