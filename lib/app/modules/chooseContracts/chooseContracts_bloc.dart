import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/models/ContractsModel.dart';

class ChooseContractsBloc extends BlocBase {
  Future saveContractsChoose(Contracts contracts) async {
    var box = await getHiveInstance();//await initHive();
    box.put("cpfCnpj", contracts.cpfCnpj);
    box.put("contrato", contracts.contrato);
    box.put("planoInternet", contracts.planoInternet);
    box.put("planoInternetId", contracts.planoInternetId);
    box.put("razaoSocial", contracts.razaoSocial);
    box.put("status", contracts.status);
    box.put("vencimento", contracts.vencimento);
    box.put("planoInternetValor", contracts.planoInternetValor);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
