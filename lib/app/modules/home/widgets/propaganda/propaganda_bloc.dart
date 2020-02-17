import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/home/home_module.dart';
import 'package:franet/app/modules/home/repository/home_repository.dart';

class PropagandaBloc extends BlocBase {
  Future getPropaganda() async {
    Map retorno = {};
    var box = await getHiveInstance(); //await initHive();
    var repository = HomeModule.to.getDependency<HomeRepository>();
    var propaganda = await repository.getPropagandaRepo(
        box.get("cpfCnpj"), box.get("senha"));
    retorno = {"propaganda": propaganda};

    return retorno;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
