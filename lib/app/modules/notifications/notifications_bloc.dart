import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/notifications/notifications_module.dart';
import 'package:franet/app/modules/notifications/repository/notifications_repository.dart';

class NotificationsBloc extends BlocBase {
  Future readNotification() async {
    Map<String, dynamic> retorno = {};
    var repository =
        NotificationsModule.to.getDependency<NotificationsRepository>();
    var box = await getHiveInstance();//await initHive();
    await repository
        .readNotificationRepository(box.get("contrato"))
        .then((onValue) {
     /* if(onValue == ""){
        retorno.addAll({"retornoID":})
      }*/
      if (onValue == "") {
        retorno.addAll({"retornoID": 1, "dados": ""});
      } else {
        onValue["notificacoes"] = modifyDateView(onValue);
        retorno.addAll({"retornoID": 0, "dados": onValue});
      }
    }).catchError((onError) {
      retorno.addAll({"retornoID": 2, "dados": ""});
    });
    return retorno;
  }

  modifyDateView(var date){
    List dadosFinal = [];
    var dadosDataNotificacao = date["notificacoes"];
    for (var item in dadosDataNotificacao) {
        var data = item["notification_date"];
        var dataSplitada = data.split(" ");
        dataSplitada[0] = alterPositionDate(dataSplitada[0]);
        item["notification_date"] = dataSplitada[0]+" às "+dataSplitada[1];
        dadosFinal.add(item);
    }
    return dadosFinal;
  }

alterPositionDate(String date){
  var data = date.split("-");
  return data[2]+"/"+data[1]+"/"+data[0];
}
  @override
  void dispose() {
    super.dispose();
  }
}
