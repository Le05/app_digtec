import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/duplicateBoleto/duplicateBoleto_module.dart';
import 'package:franet/app/modules/home/home_bloc.dart';
import 'package:franet/app/modules/invoices/invoices_module.dart';
import 'package:franet/app/modules/notifications/notifications_module.dart';
import 'package:franet/app/modules/paymentPromise/paymentPromise_module.dart';
import 'package:franet/app/modules/support/support_module.dart';
import 'package:franet/app/modules/testVelocity/testVelocity_module.dart';

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
        /* appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
        ),*/
        body: SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      //color: Colors.green,
                      //  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                      ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: FutureBuilder(
                        future: homeBloc.getPropaganda(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          if (snapshot.hasError) {
                            return Container(
                              child: Center(
                                child: Text(
                                    "Ocorreu um erro ao buscar as propagandas"),
                              ),
                            );
                          }
                          if(snapshot.data["exibe"] == false){
                            return Container();
                          }
                          return CarouselSlider.builder(
                            autoPlayInterval: Duration(seconds: 10),
                            autoPlay: true,
                            itemCount: snapshot.data.length,
                            height: MediaQuery.of(context).size.height / 3,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    "${snapshot.data["propaganda"][index]["ads_image"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        })),
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
                            top: MediaQuery.of(context).size.height / 2.4,
                            left: 30,
                            right: 30),
                        height: MediaQuery.of(context).size.height / 3,
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            Image.asset(
                              "images/contratoCancelado.png",
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 5,
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
                      //GetBar(message: "A sua fatura está vencida!!!",);
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
                        top: MediaQuery.of(context).size.height / 2.5,
                        // right: 20,
                        // left: 20
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                height: MediaQuery.of(context).size.height / 5,
                                child: InkWell(
                                  child: Card(
                                    elevation: 15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/codigobarra.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(child: Text("Segunda via")),
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
                                width: MediaQuery.of(context).size.width / 3.4,
                                height: MediaQuery.of(context).size.height / 5,
                                child: InkWell(
                                  child: Card(
                                    elevation: 15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/fatura.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                        ),
                                        SizedBox(
                                          height: 5,
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
                                width: MediaQuery.of(context).size.width / 3.4,
                                height: MediaQuery.of(context).size.height / 5,
                                child: InkWell(
                                  child: Card(
                                    elevation: 15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/propagamento.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child:
                                                Text("Promessa de Pagamento")),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                height: MediaQuery.of(context).size.height / 5,
                                child: InkWell(
                                  child: Card(
                                    elevation: 15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/suporte.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.4,
                                          height: MediaQuery.of(context)
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
                                width: MediaQuery.of(context).size.width / 3.4,
                                height: MediaQuery.of(context).size.height / 5,
                                child: InkWell(
                                  child: Card(
                                    elevation: 15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/velocidade.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text("Teste de Velocidade")),
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
                                width: MediaQuery.of(context).size.width / 3.4,
                                height: MediaQuery.of(context).size.height / 5,
                                child: InkWell(
                                  child: Card(
                                    elevation: 15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/notificacao.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: MediaQuery.of(context)
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
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
