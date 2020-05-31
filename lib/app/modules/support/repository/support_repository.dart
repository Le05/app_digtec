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
      String paramOcorrenciatipo,
      String paramMotivos) async {
    Response response;
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    if (paramMotivos == null ||
        paramOcorrenciatipo == null ||
        paramMotivos == "" ||
        paramOcorrenciatipo == "") {
     response = await dio.post(baseUrl + "/chamado", data: {
        "cpfcnpj": cpfCnpj,
        "senha": senha,
        "contrato": contrato,
        "contato": contato,
        "conteudo": conteudo
      });
    } else {
      response = await dio.post(baseUrl + "/chamado", data: {
        "cpfcnpj": cpfCnpj,
        "senha": senha,
        "contrato": contrato,
        "contato": contato,
        "conteudo": conteudo,
        "ocorrenciatipo":paramOcorrenciatipo,
        "motivoos":paramMotivos
      });
    }
    return response.data;
  }

  Future openCall0(
      String baseUrl,
      int contato,
      int contrato,
      String conteudo,
      String cpfCnpj,
      String senha,
      String paramOcorrenciatipo,
      String paramMotivos) async {
    Response response;
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    if (paramMotivos == null ||
        paramOcorrenciatipo == null ||
        paramMotivos == "" ||
        paramOcorrenciatipo == "") {
     response = await dio.post(baseUrl + "/chamado", data: {
        "cpfcnpj": cpfCnpj,
        "senha": senha,
        "contrato": contrato,
        "contato": contato,
        "conteudo": conteudo,
        "sem_os":1
      });
    } else {
      response = await dio.post(baseUrl + "/chamado", data: {
        "cpfcnpj": cpfCnpj,
        "senha": senha,
        "contrato": contrato,
        "contato": contato,
        "conteudo": conteudo,
        "ocorrenciatipo":paramOcorrenciatipo,
        "motivoos":paramMotivos,
        "sem_os":1
      });
    }
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
