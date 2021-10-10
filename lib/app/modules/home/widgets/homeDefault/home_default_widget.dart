import 'package:flutter/material.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_module.dart';
import 'package:franet/app/modules/home/home_bloc.dart';
import 'package:franet/app/modules/home/widgets/homeDefault/widgets/card/card_widget.dart';
import 'package:franet/app/modules/home/widgets/propaganda/propaganda_widget.dart';
import 'package:franet/app/modules/home/widgets/recommendation/recommendation_page.dart';
import 'package:franet/app/modules/invoices/invoices_module.dart';
import 'package:franet/app/modules/login/login_module.dart';
import 'package:franet/app/modules/notifications/notifications_module.dart';
import 'package:franet/app/modules/paymentPromise/paymentPromise_module.dart';
import 'package:franet/app/modules/support/support_module.dart';
import 'package:franet/app/modules/testVelocity/testVelocity_module.dart';
import 'package:franet/app/modules/tips/tips_module.dart';

HomeBloc homeBloc = HomeBloc();
bool exibiuMsgContrato = false;

class HomeDefaultWidget extends StatelessWidget {
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
                      snapshot.data["exibe"] == false
                          ? Container()
                          : snapshot.data["exibe"] == true &&
                                  snapshot.data["param_propagandaposicao"] ==
                                      "0"
                              ? PropagandaWidget()
                              : Container(),
                      Column(
                        children: [
                          paramUseindiqueurl == 1 ?
                          RecommendationPage() : Container(),
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
                                                      Text("CPF/CNPJ: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ButtonTheme(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            homeBloc
                                                                .getContractsHive(
                                                                    context)
                                                                .then(
                                                                    (onValue) {
                                                              if (onValue ==
                                                                  false) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      "Não existe outro contrato para ser escolhido"),
                                                                ));
                                                              }
                                                            });
                                                          },
                                                          child: Text(
                                                            "Escolher outro contrato",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      ButtonTheme(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            box.clear();
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LoginModule()));
                                                          },
                                                          child: Text(
                                                            "Sair deste cpf/cnpj",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
                              if (snapshots.data["status"] == 1) {
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
                                        "images/close.png",
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
                              if (snapshots.data["status"] == 2) {
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

                              if (snapshots.data["status"] == 3) {
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
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40))),
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
                                              25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots
                                                    .data["param_ico_faturas"],
                                                "images/fatura.png",
                                                "Faturas",
                                                false),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots.data[
                                                    "param_ico_graficoconsumo"],
                                                "images/consumo.png",
                                                "Consumo<br>de<br>internet",
                                                true),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ExtractConsumptionModule()));
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots.data[
                                                    "param_ico_promessapag"],
                                                "images/propagamento.png",
                                                "Promessa<br>de<br>Pagamento",
                                                true),
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
                                          MainAxisAlignment.spaceEvenly,
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots
                                                    .data["param_ico_suporte"],
                                                "images/suporte.png",
                                                "Suporte",
                                                false),
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots.data[
                                                    "param_ico_testedevelocidade"],
                                                "images/velocidade.png",
                                                "Teste de<br>Velocidade",
                                                true),
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots.data[
                                                    "param_ico_notificacoes"],
                                                "images/notificacao.png",
                                                "Notificações",
                                                false),
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
                                          MainAxisAlignment.spaceEvenly,
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots
                                                    .data["param_ico_dicas"],
                                                "images/dicas.png",
                                                "Dicas",
                                                false),
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots
                                                    .data["param_ico_facebook"],
                                                "images/facebook.png",
                                                "Facebook",
                                                false),
                                            onTap: () {
                                              homeBloc
                                                  .openFBInstagram(0)
                                                  .catchError((onError) {
                                                ScaffoldMessenger.of(context)
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots.data[
                                                    "param_ico_instagram"],
                                                "images/instagram.png",
                                                "Instagram",
                                                false),
                                            onTap: () {
                                              homeBloc
                                                  .openFBInstagram(1)
                                                  .catchError((onError) {
                                                ScaffoldMessenger.of(context)
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        paramurlcontratoscm != "" ||
                                                paramurlcontratoscm != null
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.1,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                child: InkWell(
                                                  child: CardWidget(
                                                      snapshots.data[
                                                          "param_icones_custom"],
                                                      snapshots.data[
                                                          "param_ico_contratoscm"],
                                                      "images/contrato.png",
                                                      "Contrato",
                                                      false),
                                                  onTap: () async {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Aguarde! Em breve o contrato será exibido.")));
                                                    await Future.delayed(
                                                        Duration(seconds: 3));
                                                    await homeBloc
                                                        .openContratoSCM(
                                                            paramurlcontratoscm);
                                                  },
                                                ),
                                              )
                                            : Container(),
                                        paramurlcontatowhats != "" ||
                                                paramurlcontratoscm != null
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.1,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                child: InkWell(
                                                  child: CardWidget(
                                                      snapshots.data[
                                                          "param_icones_custom"],
                                                      snapshots.data[
                                                          "param_ico_contatowhats"],
                                                      "images/whatsapp.png",
                                                      "WhatsApp",
                                                      false),
                                                  onTap: () async {
                                                    await homeBloc.openWhatsApp(
                                                        paramurlcontatowhats);
                                                  },
                                                ),
                                              )
                                            : Container(),
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
                                            child: CardWidget(
                                                snapshots.data[
                                                    "param_icones_custom"],
                                                snapshots.data[
                                                    "param_ico_siteprovedor"],
                                                "images/site.png",
                                                "Nosso site",
                                                false),
                                            onTap: () async {
                                              await homeBloc
                                                  .openSite(paramsiteprovedor);
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      snapshot.data["exibe"] == false
                          ? Container()
                          : snapshot.data["exibe"] == true &&
                                  snapshot.data["param_propagandaposicao"] ==
                                      "1"
                              ? PropagandaWidget()
                              : Container(),
                    ],
                  ),
                ],
              );
            }),
      )),
    );
  }
}
