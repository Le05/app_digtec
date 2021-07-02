import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:franet/app/BDHive/initHive.dart';

class PaymentCreditCardRepository extends Disposable {
  Dio dio = Dio();

  Future buscarCartoes() async {
    Response response =
        await dio.post(box.get("baseUrl") + '/cartao/list', data: {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato")
    });
    return response.data;
  }

  Future pagarComCartao(int fatura, String numero, String nome, String expira,
      String cvv, String email, bool salvarCartao) async {
    Map data = {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato"),
      "numero": numero,
      "nome": nome,
      "expira": expira,
      "cvv": cvv,
      "email": email,
      "salvar_cartao": 1
    };
    Map dataS = {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato"),
      "numero": numero,
      "nome": nome,
      "expira": expira,
      "cvv": cvv,
      "email": email,
    };
    Response response;
    if (salvarCartao == true) {
      response = await dio
          .post(box.get("baseUrl") + '/pagamento/cartao/$fatura', data: data);
      return response.data;
    } else {
      response = await dio
          .post(box.get("baseUrl") + '/pagamento/cartao/$fatura', data: dataS);
      return response.data;
    }
  }

  Future pagarComCartaoSalvo(int fatura, int cartaoId, String email) async {
    Response response;
    var url = box.get("baseUrl");
    response = await dio.post(url + '/pagamento/cartao/$fatura', data: {
      "cpfcnpj": box.get("cpfCnpj"),
      "senha": box.get("senha"),
      "contrato": box.get("contrato"),
      "email": email,
      "cartao_id": cartaoId
    });
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
