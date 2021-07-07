import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';

class HomeRepository extends Disposable {
  Dio dio = Dio();
  Future getPropagandaRepo(String cpfCnpj, String senha) async {
    Response response;
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    response = await dio
        .post("https://www.appdoprovedor.com.br/_api/read_ads.php", data: {
      "cpfcnpj": cpfCnpj,
      "senha": senha,
      "key": key,
      "token": token
    });
    return response.data;
  }

  @override
  void dispose() {}
}
