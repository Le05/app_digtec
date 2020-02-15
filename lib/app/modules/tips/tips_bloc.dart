import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TipsBloc extends BlocBase {
  Dio dio = Dio();
  Future getTips() async {
    List retorno;
    Response response;
    response = await dio.post(
        "https://www.appdoprovedor.com.br/_api/read_dicas.php",
        data: {"key": "franet", "token": "7K74P-LBSB3-XYJXA-G6MQS"});
    retorno = response.data;
    var colors = generateColorsList();
    var index = 0;
    for (var dica in retorno) {
      dica.addAll({"color": colors[index]});
      index = index + 1;
    }
    return retorno;
  }

  List<Color> generateColorsList() {
    List<Color> listColor = [];
    listColor.add(Colors.green[300]);
    listColor.add(Colors.blue[300]);
    listColor.add(Colors.red[300]);
    listColor.add(Colors.yellow[300]);
    listColor.add(Colors.orange[300]);
    listColor.add(Colors.purple[300]);
    listColor.add(Colors.amber[300]);
    return listColor;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
