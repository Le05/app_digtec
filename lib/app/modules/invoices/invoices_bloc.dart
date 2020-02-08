import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/models/TitlesModel.dart';
import 'package:franet/app/modules/invoices/invoices_module.dart';
import 'package:franet/app/modules/invoices/repository/invoices_repository.dart';

class InvoicesBloc extends BlocBase {
  Future getInvoices() async {
    var repository = InvoicesModule.to.getDependency<InvoicesRepository>();
    var box = await getHiveInstance();//await initHive();

    var response = await repository.getInvoicesRepository(box.get("cpfCnpj"),
        box.get("senha"), box.get("contrato"), box.get("baseUrl"));
    List<Titles> titles = fromJson(response);
    List<Titles> titlesPaga = [];
    List<Titles> titlesAberta = [];
    Map<String, List<Titles>> allTitles = {};
    for (var title in titles) {
      if (title.statusid == 1) {
        title.dataPagamento = withdrawDate(title.dataPagamento);
        title.vencimento = withdrawDate(title.vencimento);
        title.vencimentoAtualizado = withdrawDate(title.vencimentoAtualizado);
        titlesAberta.add(title);
      } else if (title.statusid == 2) {
        title.dataPagamento = withdrawDate(title.dataPagamento);
        title.vencimentoAtualizado = withdrawDate(title.vencimentoAtualizado);
        title.vencimento = withdrawDate(title.vencimento);
        titlesPaga.add(title);
      }
    }
    allTitles.addAll({"titlesPaga": titlesPaga, "titlesAberta": titlesAberta});
    return allTitles;
  }

  withdrawDate(String date) {
    // retira os traços das datas
    if (date != null) {
      var dateProvisorio = date.split("-");
      var dateProvisorioNew =
          dateProvisorio[2] + "/" + dateProvisorio[1] + "/" + dateProvisorio[0];
      return dateProvisorioNew;
    } else {
      return date;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
