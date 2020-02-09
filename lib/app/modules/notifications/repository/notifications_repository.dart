import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class NotificationsRepository extends Disposable {
  Dio dio = Dio();

  Future readNotificationRepository(int contrato) async {
    dio.clear();
    Response response;
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    response = await dio.post(
        "https://www.appdoprovedor.com.br/_api/read_pushnotification.php",
        data: {
          "key": "franet",
          "token": "7K74P-LBSB3-XYJXA-G6MQS",
          "contrato":contrato
        });
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
