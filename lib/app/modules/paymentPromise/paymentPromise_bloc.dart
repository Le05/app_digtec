import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/paymentPromise/paymentPromise_module.dart';
import 'package:franet/app/modules/paymentPromise/repository/paymentPromisse_repository.dart';

class PaymentPromiseBloc extends BlocBase {
  Future<Map> verifyContractsStatus() async {
    Map<String, dynamic> retorno = {};
    var box = await initHive();
    if (box.get("status") == " Suspenso") {
      retorno.addAll({
        "statusSupenso": true,
        "razaosocial": box.get("razaoSocial"),
        "contrato": box.get("contrato"),
        "planoInternet": box.get("planoInternet"),
        "status": box.get("status"),
        "cpfcnpj": box.get("cpfcnpj"),
        "senha": box.get("senha"),
        "baseUrl":box.get("baseUrl")
      });
      return retorno;
    } else {
      retorno.addAll({"status": false});
      return retorno;
    }
  }

  Future paymentPromise(String cpfcnpj, String senha, int contrato,String baseUrl) async {
     var repository = PaymentPromiseModule.to.getDependency<PaymentPromisseRepository>();
    await repository.paymentPromiseRepository(cpfcnpj, senha, contrato,baseUrl).then((onValue){
      return onValue["msg"];
    }).catchError((onError){
      return onError;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
