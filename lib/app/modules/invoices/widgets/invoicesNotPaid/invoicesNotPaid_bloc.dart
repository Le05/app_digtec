import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/invoices/invoices_module.dart';
import 'package:franet/app/modules/invoices/repository/invoices_repository.dart';

class InvoicesNotPaidBloc extends BlocBase {
  var repository = InvoicesModule.to.getDependency<InvoicesRepository>();

  Future gerarCodigoPix(int id) async {
    var box = await getHiveInstance();
    return await repository.generateCodigoPix(id, box.get("cpfCnpj"),
        box.get("senha"), box.get("contrato"), box.get("baseUrl")).then((value) => value.data);
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
