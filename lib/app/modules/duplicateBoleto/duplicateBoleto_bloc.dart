import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/duplicateBoleto/duplicateBoleto_module.dart';
import 'package:franet/app/modules/duplicateBoleto/repository/duplicate_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class DuplicateBoletoBloc extends BlocBase {
  Future getDados2Via() async {
    var repository =
        DuplicateBoletoModule.to.getDependency<DuplicateRepository>();
    var retorno;
    await repository.getFatura2Via().then((onValue) {
      onValue["vencimento"] = withdrawDate(onValue["vencimento"]);
      retorno = onValue;
      fatura = onValue["fatura"];
    });
    return retorno;
  }

  Future postFatura2Via(String tipo) async {
    var repository =
        DuplicateBoletoModule.to.getDependency<DuplicateRepository>();
    var retorno;
    await repository.postFatura2Via(tipo).then((onValue){
      retorno = onValue;
    });
    return retorno;
  }

  launchPDF(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return 0;
    }
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
