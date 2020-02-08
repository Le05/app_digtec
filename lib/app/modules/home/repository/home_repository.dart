import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class HomeRepository extends Disposable {
  Dio dio = Dio();
  Future getPropagandaRepo(String cpfCnpj, String senha) async {
    Response response;
    dio.clear();
    response = await dio
        .post("https://www.appdoprovedor.com.br/_api/read_ads.php", data: {
      "cpfcnpj": cpfCnpj,
      "senha": senha,
      "key": "franet",
      "token": "7K74P-LBSB3-XYJXA-G6MQS"
    });
    return response.data;
  }

  @override
  void dispose() {}
}
