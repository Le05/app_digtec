import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/invoices/invoices_module.dart';
import 'package:franet/app/modules/invoices/repository/invoices_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoicesNotPaidBloc extends BlocBase {
  var repository = InvoicesModule.to.getDependency<InvoicesRepository>();
  launchPDF(String url) async {
    var box = await getHiveInstance(); //initHive();
    String ip = box.get("baseUrl");
    ip = ip.trim();
    List<String> splitada = ip.split("/");
    url = "${splitada[0]}//${splitada[2]}" + url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return 0;
    }
  }

  Future gerarCodigoPix(int id) async {
    var box = await getHiveInstance();
    return await repository.generateCodigoPix(id, box.get("cpfCnpj"),
        box.get("senha"), box.get("contrato"), box.get("baseUrl"));
  }

  Future buscarGateway(int id) async {
    return await repository.buscarGatewayPagamento(
        id, box.get("cpfCnpj"), box.get("senha"), box.get("contrato")).then((value) => value.data);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
