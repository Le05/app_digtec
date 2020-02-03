import 'package:flutter/material.dart';
import 'package:franet/app/modules/notifications/notifications_bloc.dart';

class NotificationsPage extends StatefulWidget {
  final String title;
  const NotificationsPage({Key key, this.title = "Notificações"})
      : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

NotificationsBloc notificationsBloc = NotificationsBloc();

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: notificationsBloc.readNotification(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Ocorreu um erro ao buscar as faturas"),
                );
              }
              if (snapshot.data["retornoID"] == 1) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          "images/semNotificacoes.png",
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Você não tem nenhuma notificação!!!",
                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            }));
  }
}
