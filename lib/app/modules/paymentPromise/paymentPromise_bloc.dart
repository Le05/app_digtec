import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/modules/paymentPromise/paymentPromise_module.dart';
import 'package:app_digtec/app/modules/paymentPromise/repository/paymentPromisse_repository.dart';
import 'package:rxdart/rxdart.dart';

class PaymentPromiseBloc extends BlocBase {
  Future<Map> verifyContractsStatus() async {
    Map<String, dynamic> retorno = {};
    var box = await getHiveInstance();//await initHive();
    if (box.get("status") == " Suspenso" || box.get("status") == " Ativo V. Reduzida") {
      retorno.addAll({
        "statusSupenso": true,
        "razaosocial": box.get("razaoSocial"),
        "contrato": box.get("contrato"),
        "planoInternet": box.get("planoInternet"),
        "status": box.get("status"),
        "cpfCnpj": box.get("cpfCnpj"),
        "senha": box.get("senha"),
        "baseUrl":box.get("baseUrl"),
        "param_txtpromessapag":box.get("param_txtpromessapag"),
      });
      return retorno;
    } else {
      retorno.addAll({"status": false,"param_txtpromessapagok":box.get("param_txtpromessapagok")});
      return retorno;
    }
  }

  Future paymentPromise(String cpfcnpj, String senha, int contrato,String baseUrl) async {
    var msg;
     var repository = PaymentPromiseModule.to.getDependency<PaymentPromisseRepository>();
    await repository.paymentPromiseRepository(cpfcnpj, senha, contrato,baseUrl).then((onValue){
      msg = onValue["msg"];
    }).catchError((onError){
      msg = onError;
    });
    return msg;
  }

final BehaviorSubject<bool> _animacaoButton = BehaviorSubject<bool>();
  Sink<bool> get inputButton => _animacaoButton.sink;
  Stream get outputButton => _animacaoButton.stream;

  animacaoButton(bool anime) {
    inputButton.add(anime);
  }
  @override
  void dispose() {
    _animacaoButton.close();
    super.dispose();
  }
}
