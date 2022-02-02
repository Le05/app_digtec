import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/models/TitlesModel.dart';
import 'package:app_digtec/app/modules/invoices/invoices_module.dart';
import 'package:app_digtec/app/modules/invoices/repository/invoices_repository.dart';

class InvoicesBloc extends BlocBase {
  var repository = InvoicesModule.to.getDependency<InvoicesRepository>();
  Future getInvoices() async {
    var box = await getHiveInstance(); //await initHive();

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
      }
    }

    for (var i = titles.length - 1; i >= 0; i--) {
      if (titles[i].statusid == 2) {
        titles[i].dataPagamento = withdrawDate(titles[i].dataPagamento);
        titles[i].vencimentoAtualizado =
            withdrawDate(titles[i].vencimentoAtualizado);
        titles[i].vencimento = withdrawDate(titles[i].vencimento);
        titlesPaga.add(titles[i]);
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
