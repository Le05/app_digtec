import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_module.dart';
import 'package:franet/app/modules/extractConsumption/repository/extractConsumption_repository.dart';

class ConsumptioImagesBloc extends BlocBase {
  var extractRepository =
      ExtractConsumptionModule.to.getDependency<ExtractConsumptionRepository>();

  Future buscarConsumoImages() async {
    return await extractRepository.buscarConsumo("2020", "1");
  }
  @override
  void dispose() {
    super.dispose();
  }
}
