import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class SupportRepository extends Disposable {
  Dio dio = Dio();

  Future openCall(
      String baseUrl,
      int contato,
      int contrato,
      String conteudo,
      String cpfCnpj,
      String senha,
      String paramAbreos,
      String paramOcorrenciatipo,
      String paramMotivos) async {
    Response response;
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    Map params = {
      "cpfcnpj": cpfCnpj,
      "senha": senha,
      "contrato": contrato,
      "contato": contato,
      "conteudo": conteudo,
    };

    if (paramAbreos == "0") {
      params["ocorrenciatipo"] = paramOcorrenciatipo;
      params["sem_os"] = 1;
    } else if (paramAbreos == "1") {
      params["ocorrenciatipo"] = paramOcorrenciatipo;
      params["motivoos"] = paramMotivos;
    }

    response = await dio.post(baseUrl + "/chamado", data: params);
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
