import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class SupportRepository extends Disposable {
  Dio dio = Dio();

  Future openCall(String baseUrl,int contato,int contrato,String conteudo) async {
    Response response;
    dio.clear();
    response = await dio.post(baseUrl, data: {
      "contrato": contrato,
      "contato": contato,
      "conteudo": conteudo
    });
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
