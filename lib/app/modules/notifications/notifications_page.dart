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
                return Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/semInternet.png",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Parece que você está sem internet!",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Text("Verique sua conexão para acessar o app",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
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
                          "Não encontramos nenhuma ",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "notificaçao para ser exibida!!!",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data["dados"]["notificacoes"].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        elevation: 10,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  "images/pushnotification.png",
                                  width: MediaQuery.of(context).size.width / 7,
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, top: 0, bottom: 5),
                                    width: MediaQuery.of(context).size.width /
                                        1.24,
                                    child: Text(
                                      snapshot.data["dados"]["notificacoes"]
                                          [index]["notification_title"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    width: MediaQuery.of(context).size.width /
                                        1.24,
                                    child: Text(
                                      snapshot.data["dados"]["notificacoes"]
                                          [index]["notification_desc"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        top:
                                            MediaQuery.of(context).size.height /
                                                40),
                                    width: MediaQuery.of(context).size.width /
                                        2.38,
                                    child: Text(
                                      snapshot.data["dados"]["notificacoes"]
                                          [index]["notification_date"],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
                },
              );
            }));
  }
}
