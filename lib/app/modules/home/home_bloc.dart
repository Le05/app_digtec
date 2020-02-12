import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/models/ContractsModel.dart';
import 'package:franet/app/modules/chooseContracts/chooseContracts_module.dart';
import 'package:franet/app/modules/home/home_module.dart';
import 'package:franet/app/modules/home/repository/home_repository.dart';

class HomeBloc extends BlocBase {
  Future getPropaganda() async {
    Map retorno = {};
    var box = await getHiveInstance(); //await initHive();
    if (box.get("param_propaganda") == "1") {
      var repository = HomeModule.to.getDependency<HomeRepository>();
      var propaganda = await repository.getPropagandaRepo(
          box.get("cpfCnpj"), box.get("senha"));
      retorno = {"exibe": true, "propaganda": propaganda};
    } else {
      retorno = {"exibe": false, "propaganda": null};
    }

    return retorno;
  }

  validateContrato() async {
    var box = await getHiveInstance(); //initHive();
    String status = box.get("status");
    if (status.trim() == "Ativo") return 0;
    if (status.trim() == "Cancelado") return 1;
    if (status.trim() == "Suspenso") return 2;
    if (status.trim() == "Ativo V. Reduzida") return 3;
  }

  Future getDataContract() async {
    var box = await getHiveInstance();
    return {
      "cpfCnpj": box.get("cpfCnpj"),
      "razaoSocial": box.get("razaoSocial"),
      "status": box.get("status"),
      "contrato": box.get("contrato")
    };
  }

  Future getContractsHive(BuildContext context) async {
    var box = await getHiveInstance();
    List<Contracts> contracts = box.get("contracts");
    if (contracts == null) {
      return false;
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChooseContractsModule(contracts)));
    }
  }

  Future<void> mensagemStatusContrato(
      BuildContext context, String conteudo, String titulo) async {
    await Future.delayed(Duration(seconds: 1));
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("$conteudo"),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
