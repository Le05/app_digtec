import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_module.dart';
import 'package:franet/app/modules/extractConsumption/repository/extractConsumption_repository.dart';
import 'package:rxdart/rxdart.dart';

class ConsumptionBloc extends BlocBase {
    TextEditingController dataConsumoController = TextEditingController();
  var extractRepository =
      ExtractConsumptionModule.to.getDependency<ExtractConsumptionRepository>();

  final BehaviorSubject<dynamic> _consumo = BehaviorSubject<dynamic>();
  Sink<dynamic> get inputConsumo => _consumo.sink;
  Stream get outputConsumo => _consumo.stream;

  Future buscaConsumo() async {
    var data = dataConsumoController.text.split("/");
    var resposta = await extractRepository.buscarConsumo(data[2], data[1]);
    for (var i = 0; i < resposta["list"].length; i++) {
      resposta["list"][i]["horarioini"] =
          modificarDataHora(resposta["list"][i]["dataini"])["hora"];
      resposta["list"][i]["dataini"] =
          modificarDataHora(resposta["list"][i]["dataini"])["data"];
      resposta["list"][i]["horariofim"] =
          modificarDataHora(resposta["list"][i]["datafim"])["hora"];
      resposta["list"][i]["datafim"] =
          modificarDataHora(resposta["list"][i]["datafim"])["data"];
    }
    inputConsumo.add(resposta);
  }

  modificarDataHora(String data) {
    if (data != null) {
      var data1 = data.split("T");
      var dataNova = data1[0].split("-");
      var splitRestoDada = dataNova[2].split(" ");
      dataNova[2] = splitRestoDada[0];
      var dataNova1 = "${dataNova[2]}/${dataNova[1]}/${dataNova[0]}";
      return {"data": dataNova1, "hora": data1[1]};
    }else{
      return  {"data": null, "hora": null};
    }
  }

  Future selectDate(context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2030));
    if (picked != null) {
      modificarData(picked.toString());
    }
  }

  modificarData(String data) {
    var dataNova = data.split("-");
    var splitRestoDada = dataNova[2].split(" ");
    dataNova[2] = splitRestoDada[0];
    var dataNova1 = "${dataNova[2]}/${dataNova[1]}/${dataNova[0]}";
    dataConsumoController.text = dataNova1;
  }
  
  @override
  void dispose() {
    _consumo.close();
    super.dispose();
  }
}
