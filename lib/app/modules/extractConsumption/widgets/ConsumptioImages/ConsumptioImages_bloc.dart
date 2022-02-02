import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/modules/extractConsumption/extractConsumption_module.dart';
import 'package:app_digtec/app/modules/extractConsumption/repository/extractConsumption_repository.dart';

class ConsumptioImagesBloc extends BlocBase {
  var extractRepository =
      ExtractConsumptionModule.to.getDependency<ExtractConsumptionRepository>();

  String url;

  Future buscarConsumoImages() async {
    splitUrl();
    return await extractRepository.buscarConsumo("2020", "1");
  }

  Future splitUrl() async {
    var url1 = box.get("baseUrl");
    var urlsplit = url1.split('ws');
    url = urlsplit[0];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
