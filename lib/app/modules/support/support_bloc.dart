import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/support/repository/support_repository.dart';
import 'package:franet/app/modules/support/support_module.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportBloc extends BlocBase {
  TextEditingController contatoController = TextEditingController();
  TextEditingController conteudoController = TextEditingController();

  Future openCall() async {
    var box = await getHiveInstance();
    var repository = SupportModule.to.getDependency<SupportRepository>();
    Map retorno;
    await repository
        .openCall(box.get("baseUrl"), int.parse(contatoController.text),
            box.get("contrato"), conteudoController.text,box.get("cpfCnpj"),box.get("senha"))
        .then((onValue) {
      if (onValue["status"] == 0) {
        retorno = {"status":0,"msg":"Chamado aberto com sucesso"};
        //this.noti.showInfo('Chamado aberto com sucesso.', 5000);
      } else if (onValue["status"] == 3) {
        //"Já existe chamado aberto para o tipo selecionado"
        retorno = {"status":3,"msg":onValue["msg"]};
        //this.noti.showInfo(chamado.msg, 5000);
      }
    }).catchError((onError){
      retorno = {"status":1,"msg":"Ocorreu um erro ao abrir o chamado"};
    });
    return retorno;
  }

final BehaviorSubject<bool> _animacaoButton = BehaviorSubject<bool>();
  Sink<bool> get inputanimacaoButton => _animacaoButton.sink;
  Stream get outputanimacaoButton => _animacaoButton.stream;

  animacaoButton(bool anime) {
    inputanimacaoButton.add(anime);
  }

  getTxtOs() async {
    var box = await getHiveInstance();
    return box.get("param_txtaberturaos");
  }

  Future openWhatsApp(String telefone) async {
    await launch("https://wa.me/+55$telefone?text=Olá,estou com problemas na minha internet");
  }
  @override
  void dispose() {
    _animacaoButton.close();
    super.dispose();
  }
}
