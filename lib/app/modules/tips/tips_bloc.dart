import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';

class TipsBloc extends BlocBase {
  Future getTips() async {
    //List retorno;
    Response response;
    response = await dio.post(
        "https://www.appdoprovedor.com.br/_api/read_dicas.php",
        data: {"key": key, "token": token});
    //retorno = response.data;
    /*var colors = generateColorsList();
    var index = 0;
    for (var dica in retorno) {
      dica.addAll({"color": colors[index]});
      index = index + 1;
    }*/
    return response.data;
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
