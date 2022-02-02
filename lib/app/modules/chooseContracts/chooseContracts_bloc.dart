import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/models/ContractsModel.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';

class ChooseContractsBloc extends BlocBase {
  Future saveContractsChoose(Contracts contracts) async {
    var box = await getHiveInstance(); //await initHive();
    box.put("cpfCnpj", contracts.cpfCnpj);
    box.put("contrato", contracts.contrato);
    box.put("planoInternet", contracts.planoInternet);
    box.put("planoInternetId", contracts.planoInternetId);
    box.put("razaoSocial", contracts.razaoSocial);
    box.put("status", contracts.status);
    box.put("vencimento", contracts.vencimento);
    box.put("planoInternetValor", contracts.planoInternetValor);
    emails = contracts.emails;
  }

  Future enviarDadosDispositivo(contrato) async {
    String deviceID = box.get("deviceID");
    String plataforma = box.get("plataforma");
    await dio.post("https://www.appdoprovedor.com.br/_api/write_dispositivo.php", data: {
      "codAparelho": deviceID,
      "key": key,
      "token": token,
      "playerId": playerId,
      "contrato": contrato.contrato,
      "plataforma": plataforma
    }).then((value){
      print(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
