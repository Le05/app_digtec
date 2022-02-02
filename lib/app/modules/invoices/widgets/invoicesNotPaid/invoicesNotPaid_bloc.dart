import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/modules/invoices/invoices_module.dart';
import 'package:app_digtec/app/modules/invoices/repository/invoices_repository.dart';

class InvoicesNotPaidBloc extends BlocBase {
  var repository = InvoicesModule.to.getDependency<InvoicesRepository>();

  Future gerarCodigoPix(int id) async {
    var box = await getHiveInstance();
    return await repository.generateCodigoPix(id, box.get("cpfCnpj"),
        box.get("senha"), box.get("contrato"), box.get("baseUrl"));
  }

  Future buscarGateway(int id) async {
    return await repository
        .buscarGatewayPagamento(
            id, box.get("cpfCnpj"), box.get("senha"), box.get("contrato"))
        .then((value) => value.data);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
