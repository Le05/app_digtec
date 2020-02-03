import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/modules/notifications/notifications_module.dart';
import 'package:franet/app/modules/notifications/repository/notifications_repository.dart';

class NotificationsBloc extends BlocBase {
  Future readNotification() async {
    Map<String, dynamic> retorno = {};
    var repository =
        NotificationsModule.to.getDependency<NotificationsRepository>();
    var box = await initHive();
    await repository
        .readNotificationRepository(box.get("contrato"))
        .then((onValue) {
      if (onValue["error"] == " Nenhum registro encontrado") {
        retorno.addAll({"retornoID": 1, "dados": ""});
        
      } else {
        retorno.addAll({"retornoID": 0, "dados": ""});
      }
    }).catchError((onError) {
      retorno.addAll({"retornoID": 2, "dados": ""});
    });
    return retorno;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
