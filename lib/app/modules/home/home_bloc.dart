import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';
import 'package:app_digtec/app/models/ContractsModel.dart';
import 'package:app_digtec/app/modules/chooseContracts/chooseContracts_module.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBloc extends BlocBase {
  Future getPropaganda() async {
    if (base64.encode(utf8.encode(key + token)) != cripto)
          token = cripto;
    Map retorno = {};
    var box = await getHiveInstance(); //await initHive();
    if (box.get("param_propaganda") == "1") {
      retorno = {"exibe": true,"param_propagandaposicao":box.get("param_propagandaposicao")};
    } else {
      retorno = {"exibe": false};
    }

    return retorno;
  }

  validateContrato() async {
    Map retorno = {};
    var box = await getHiveInstance(); //initHive();
    String status = box.get("status");
 if (status.trim() == "Ativo") retorno.addAll({"status": 0});
      if (status.trim() == "Cancelado") retorno.addAll({"status": 1});
      if (status.trim() == "Suspenso") retorno.addAll({"status": 2});
      if (status.trim() == "Ativo V. Reduzida") retorno.addAll({"status": 3});

    if (box.get("param_icones_custom") == "1") {
     /* var file = await DefaultCacheManager()
          .getFileFromCache(box.get("param_ico_segundavia"));*/
    /*  if (file == null) {
        await DefaultCacheManager()
            .downloadFile(box.get("param_ico_segundavia"));
        await DefaultCacheManager().downloadFile(box.get("param_ico_faturas"));
        await DefaultCacheManager()
            .downloadFile(box.get("param_ico_promessapag"));
        await DefaultCacheManager().downloadFile(box.get("param_ico_suporte"));
        await DefaultCacheManager()
            .downloadFile(box.get("param_ico_testedevelocidade"));
        await DefaultCacheManager()
            .downloadFile(box.get("param_ico_notificacoes"));
        await DefaultCacheManager().downloadFile(box.get("param_ico_dicas"));
        await DefaultCacheManager().downloadFile(box.get("param_ico_facebook"));
        await DefaultCacheManager()
            .downloadFile(box.get("param_ico_instagram"));
        await DefaultCacheManager()
            .downloadFile(box.get("param_ico_graficoconsumo"));
      } else {*/
        retorno.addAll({
          "param_icones_custom": box.get("param_icones_custom"),
          "param_ico_segundavia": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_segundavia"),
          "param_ico_faturas": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_faturas"),
          "param_ico_promessapag": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_promessapag"),
          "param_ico_suporte": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_suporte"),
          "param_ico_testedevelocidade": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_testedevelocidade"),
          "param_ico_notificacoes": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_notificacoes"),
          "param_ico_dicas": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_dicas"),
          "param_ico_facebook": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_facebook"),
          "param_ico_instagram": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_instagram"),
          "param_ico_graficoconsumo": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_graficoconsumo"),
          "param_ico_contatowhats": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_contatowhats"),
          "param_ico_contratoscm": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_contratoscm"),
          "param_ico_siteprovedor": /*await DefaultCacheManager().getFileFromCache(*/box.get("param_ico_siteprovedor")
        });
      //}
    } else {
      retorno.addAll({"param_icones_custom": box.get("param_icones_custom")});
    }
    return retorno;
  }

  Future getDataContract() async {
    var box = await getHiveInstance();
    if (base64.encode(utf8.encode(key + token)) != cripto)
          token = cripto;
    return {
      "cpfCnpj": box.get("cpfCnpj"),
      "razaoSocial": box.get("razaoSocial"),
      "status": box.get("status"),
      "contrato": box.get("contrato"),
      "plano":box.get("planoInternet"),
      "valor":box.get("planoInternetValor"),
      "vencimento":box.get("vencimento")
    };
  }

  Future getContractsHive(BuildContext context) async {
    //var box = await getHiveInstance();
    //List<Contracts> contracts = box.get("contracts");
    if (contracts == null) {
      return false;
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChooseContractsModule(contracts)));
    }
  }

  Future openFBInstagram(int escolha) async {
    // 0 -> facebook
    // 1 -> instagram
    var box = await getHiveInstance();
    if(escolha == 0){
      await launch(box.get("param_facebook"));
    }else if(escolha == 1){
      await launch(box.get("param_instagram"));
    }
    
  }

    Future openContratoSCM(String urlContrato) async {
      await launch(urlContrato);
  }
    Future openSite(String site) async {
      await launch(site);
  }
      Future openWhatsApp(String urlWhats) async {
      await launch(urlWhats);
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
                    TextButton(
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
