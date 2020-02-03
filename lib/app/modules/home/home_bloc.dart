import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/home/home_module.dart';
import 'package:franet/app/modules/home/repository/home_repository.dart';

class HomeBloc extends BlocBase {
   

  Future getPropaganda() async {
     var repository = HomeModule.to.getDependency<HomeRepository>();
      var box = await initHive();
     var propaganda = await repository.getPropagandaRepo(box.get("cpfCnpj"), box.get("senha"));
     return propaganda;
  }
  
  validateContrato() async {
     var box = await initHive();
     String status = box.get("status");
     if(status.trim() == "Ativo")
      return 0;
     if(status.trim() == "Cancelado")
      return 1;
    if(status.trim() == "Suspenso")
      return 2;
    if(status.trim() == "Ativo V. Reduzida")
      return 3;
  }

Future<void> mensagemStatusContrato(BuildContext context, String conteudo,String titulo) async {
  await Future.delayed(Duration(seconds: 1));
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
