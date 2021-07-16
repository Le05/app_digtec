import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/support/repository/support_repository.dart';
import 'package:franet/app/modules/support/support_module.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportBloc extends BlocBase {
  TextEditingController contatoController =
      new MaskedTextController(mask: '(00)00000-0000');
  TextEditingController conteudoController = TextEditingController();
  int itemSelecionado;

  Future openCall() async {
    var box = await getHiveInstance();
    var repository = SupportModule.to.getDependency<SupportRepository>();
    Map retorno;

    String paramAbreos = box.get("param_abreos");
    String ocorrenciaTipo = box.get("param_ocorrenciatipo");
    String paramMotivos = box.get("param_motivoos");

    if (paramUseTypeOcorrence == 1) {
      for (var ocorrencia in paramTypeOcorrence) {
        if (itemSelecionado ==
            int.parse(ocorrencia["param_idtipoocorrencia"])) {
          paramAbreos = ocorrencia["param_abreos"];
          ocorrenciaTipo = ocorrencia["param_idtipoocorrencia"];
          paramMotivos = ocorrencia["param_motivoos"];
        }
      }
    }

    await repository
        .openCall(
            box.get("baseUrl"),
            int.parse(removeCaractersPhone(contatoController.text)),
            box.get("contrato"),
            conteudoController.text,
            box.get("cpfCnpj"),
            box.get("senha"),
            paramAbreos,
            ocorrenciaTipo,
            paramMotivos)
        .then((onValue) {
      if (onValue["status"] == 0) {
        retorno = {"status": 0, "msg": "Chamado aberto com sucesso"};
        //this.noti.showInfo('Chamado aberto com sucesso.', 5000);
      } else if (onValue["status"] == 3) {
        //"Já existe chamado aberto para o tipo selecionado"
        retorno = {"status": 3, "msg": onValue["msg"]};
        //this.noti.showInfo(chamado.msg, 5000);
      }
    }).catchError((onError) {
      retorno = {"status": 1, "msg": "Ocorreu um erro ao abrir o chamado"};
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

  getPhones() async {
    var box = await getHiveInstance();
    return {
      "param_telprincipal": box.get("param_telprincipal"),
      "param_telsecundario": box.get("param_telsecundario"),
      "param_telwhats": box.get("param_telwhats")
    };
  }

  Future openWhatsApp(String telefone) async {
    telefone = removeCaractersPhone(telefone);
    await launch(
        "https://api.whatsapp.com/send?phone=+55$telefone&text=Olá,estou com problemas na minha internet");
  }

  Future openDiskPhone(String telefone) async {
    telefone = removeCaractersPhone(telefone);
    await launch("tel:$telefone");
  }

  removeCaractersPhone(String telefone) {
    telefone = telefone.replaceAll("(", "");
    telefone = telefone.replaceAll(")", "");
    telefone = telefone.replaceAll("-", "");
    telefone = telefone.replaceAll(" ", "");
    return telefone;
  }

  final BehaviorSubject<int> _dropbutton = BehaviorSubject<int>();
  Sink<int> get inputDropButton => _dropbutton.sink;
  Stream get outputDropButton => _dropbutton.stream;

  dropButtonSelected(int selectedItem) {
    itemSelecionado = selectedItem;
    inputDropButton.add(selectedItem);
  }

  @override
  void dispose() {
    _animacaoButton.close();
    _dropbutton.close();
    super.dispose();
  }
}
