import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/duplicateBoleto/duplicateBoleto_module.dart';
import 'package:franet/app/modules/home/home_bloc.dart';
import 'package:franet/app/modules/home/widgets/propaganda/propaganda_widget.dart';
import 'package:franet/app/modules/invoices/invoices_module.dart';
import 'package:franet/app/modules/notifications/notifications_module.dart';
import 'package:franet/app/modules/paymentPromise/paymentPromise_module.dart';
import 'package:franet/app/modules/support/support_module.dart';
import 'package:franet/app/modules/testVelocity/testVelocity_module.dart';
import 'package:franet/app/modules/tips/tips_module.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Dashboard"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

HomeBloc homeBloc = HomeBloc();
bool exibiuMsgContrato = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: homeBloc.getPropaganda(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Ocorreu um erro ao obter os dados"),
                    );
                  }
                  return ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          snapshot.data["exibe"] == false ? Container():
                          snapshot.data["exibe"] == true &&
                                  snapshot.data["param_propagandaposicao"] ==
                                      "0"
                              ? PropagandaWidget()
                              : Container(),
                          Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 40,
                                  left: 5,
                                  right: 5),
                              width: MediaQuery.of(context).size.width,
                              //height: MediaQuery.of(context).size.height / 6,
                              child: Card(
                                child: FutureBuilder(
                                    future: homeBloc.getDataContract(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return Container(
                                            child: Text(
                                                "Ocorreu um erro ao obter os dados"));
                                      }
                                      return Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 0, top: 5),
                                          child: ExpansionTile(
                                            title: Row(
                                              children: <Widget>[
                                                Text(
                                                  "Contrato: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "${snapshot.data["contrato"]}"),
                                              ],
                                            ),
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Nome/Razão Social: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.76,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Text(snapshot
                                                                    .data[
                                                                "razaoSocial"]),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "CPF/CNPJ: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(snapshot
                                                          .data["cpfCnpj"]),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Status do Contrato: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(snapshot
                                                          .data["status"]),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Contrato: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "${snapshot.data["contrato"]}"),
                                                    ],
                                                  ),
                                                  Center(
                                                    child: ButtonTheme(
                                                      child: RaisedButton(
                                                          child: Text(
                                                            "Escolher outro contrato",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            homeBloc
                                                                .getContractsHive(
                                                                    context)
                                                                .then(
                                                                    (onValue) {
                                                              if (onValue ==
                                                                  false) {
                                                                Scaffold.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      "Não existe outro contrato para ser escolhido"),
                                                                ));
                                                              }
                                                            });
                                                          }),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ));
                                    }),
                              )),
                          FutureBuilder(
                            future: homeBloc.validateContrato(),
                            builder: (context, snapshots) {
                              if (!snapshots.hasData) {
                                return Container();
                              }
                              if (snapshots.data == 1) {
                                // contrato cancelado
                                //Contrato cancelado, volte a utilizar nossos serviços
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          2.4,
                                      left: 30,
                                      right: 30),
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: Center(
                                      child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "images/contratoCancelado.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                      ),
                                      Text(
                                        "O seu contrato está cancelado! Por Favor, entre em contato conosco para ativa-lo novamente",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ],
                                  )),
                                );
                              }
                              if (snapshots.data == 2) {
                                // contrato suspenso
                                //Fatura vencida, sua internet está bloqueada.
                                if (exibiuMsgContrato == false) {
                                  exibiuMsgContrato = true;
                                  homeBloc.mensagemStatusContrato(
                                      context,
                                      "Sua Fatura está vencida, sua internet está bloqueada!!",
                                      "Contrato Suspenso");
                                }
                              }

                              if (snapshots.data == 3) {
                                //conta vencida
                                //Fatura vencida, sua velocidade está reduzida.
                                if (exibiuMsgContrato == false) {
                                  exibiuMsgContrato = true;
                                  homeBloc.mensagemStatusContrato(
                                      context,
                                      "Sua Fatura está vencida, sua internet está com a velocidade reduzida",
                                      "Fatura Vencida");
                                }
                              }
                              return Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                margin: EdgeInsets.only(
                                    //top: MediaQuery.of(context).size.height / 2.2,
                                    // right: 20,
                                    // left: 20
                                    ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              35,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/codigobarra.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.1,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                      child:
                                                          Text("Segunda via")),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          DuplicateBoletoModule()));
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/fatura.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text("Faturas"),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          InvoicesModule()));
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/propagamento.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.1,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            11,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("Promessa"),
                                                          Text("de"),
                                                          Text("Pagamento")
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentPromiseModule()));
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/suporte.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.1,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("Suporte"),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupportModule()));
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/velocidade.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.1,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text("Teste de"),
                                                          Text("Velocidade")
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TestVelocityModule()));
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/notificacao.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("Notificações"),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NotificationsModule()));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/dicas.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("Dicas"),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TipsModule()));
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/facebook.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("Facebook"),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              homeBloc
                                                  .openFBInstagram(0)
                                                  .catchError((onError) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Ocorreu um erro ao abrir o Facebook"),
                                                ));
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: InkWell(
                                            child: Card(
                                              elevation: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/instagram.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("Instagram"),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              homeBloc
                                                  .openFBInstagram(1)
                                                  .catchError((onError) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Ocorreu um erro ao abrir o Instagram"),
                                                ));
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          snapshot.data["exibe"] == false ? Container():
                          snapshot.data["exibe"] == true &&
                                  snapshot.data["param_propagandaposicao"] ==
                                      "1"
                              ? PropagandaWidget()
                              : Container(),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ));
  }
}
