import 'package:flutter/material.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/home/home_bloc.dart';
import 'package:franet/app/modules/home/widgets/homeCustomFirst/widgets/CardAcessoRapido/card_acesso_rapido_widget.dart';

HomeBloc homeBloc = HomeBloc();

class HomeCustomFirstWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            imagemFundoExibir2 == 1
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Image.network(
                      imageFundo2,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.cover,
                    ),
                    // color: Colors.red,
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    color: Color(int.parse(cor)),
                  ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.file(
                          logoTipo,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: homeBloc.getDataContract(),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (!snapshot.hasData) {
                          return Container(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Container(
                              child: Text("Ocorreu um erro ao obter os dados"));
                        }

                        return Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5, top: 15),
                                    child: Text(
                                      "Olá ${snapshot.data["razaoSocial"]}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                                color: Colors.grey,
                                                blurRadius: 2)
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5, top: 15),
                                    child: Text(
                                      "Como podemos ajudar?",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5, top: 15),
                                    child: Text(
                                      "Acesso rápido",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                // color: Colors.green,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/fatura.png",
                                      label: "Fatura",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/consumo.png",
                                      label: "Consumo de banda",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/propagamento.png",
                                      label: "Promessa de pagamento",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/suporte.png",
                                      label: "Suporte",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/velocidade.png",
                                      label: "Teste de velocidade",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/notificacao.png",
                                      label: "Notificações",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/dicas.png",
                                      label: "Dicas",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/facebook.png",
                                      label: "Facebook",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/instagram.png",
                                      label: "Instagram",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/contrato.png",
                                      label: "Contrato",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/whatsapp.png",
                                      label: "WhatsApp",
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/site.png",
                                      label: "Nosso site",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.55 -
                                        40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Status do serviço",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${snapshot.data["status"]}",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Nº do contrato",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${snapshot.data["contrato"]}",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Plano atual",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${snapshot.data["plano"]}",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Valor: R\$ ${snapshot.data["valor"]}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Vencimento: Todo dia ${snapshot.data["vencimento"]}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 15),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                                  child: Icon(
                                                    Icons.phone,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top:5),
                                                  child: Text("Telefone"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            
                                             margin: EdgeInsets.only(left:10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                                  child: Icon(
                                                    Icons.phone,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top:5),
                                                  child: Text("WhatsApp"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            
                                             margin: EdgeInsets.only(left:10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                                  child: Icon(
                                                    Icons.phone,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top:5),
                                                  child: Text("Facebook"),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
