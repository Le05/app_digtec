import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/support/repository/support_repository.dart';
import 'package:franet/app/modules/support/support_module.dart';

class SupportBloc extends BlocBase {
  TextEditingController contatoController = TextEditingController();
  TextEditingController conteudoController = TextEditingController();

  Future openCall() async {
    var box = await getHiveInstance();
    var repository = SupportModule.to.getDependency<SupportRepository>();
    int retorno;
    await repository
        .openCall(box.get("baseUrl"), int.parse(contatoController.text),
            box.get("contrato"), conteudoController.text)
        .then((onValue) {
      if (onValue["status"] == 0) {
        retorno = 0;
        //this.noti.showInfo('Chamado aberto com sucesso.', 5000);
      } else if (onValue["status"] == 3) {
        retorno = 3;
        //this.noti.showInfo(chamado.msg, 5000);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
