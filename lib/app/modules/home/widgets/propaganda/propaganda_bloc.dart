import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/modules/home/home_module.dart';
import 'package:app_digtec/app/modules/home/repository/home_repository.dart';

class PropagandaBloc extends BlocBase {
  Future getPropaganda() async {
    Map retorno = {};
    var box = await getHiveInstance(); //await initHive();
    var repository = HomeModule.to.getDependency<HomeRepository>();
    var propaganda = await repository.getPropagandaRepo(
        box.get("cpfCnpj"), box.get("senha"));
    retorno = {
      "propaganda": propaganda,
      "param_propagandatitulo": box.get("param_propagandatitulo")
    };
    return retorno;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
