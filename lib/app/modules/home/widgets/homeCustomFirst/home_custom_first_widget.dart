import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:franet/app/functionsGlobals/functionsGlobals.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/models/ContractsModel.dart';
import 'package:franet/app/modules/chooseContracts/chooseContracts_module.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_module.dart';
import 'package:franet/app/modules/home/home_bloc.dart';
import 'package:franet/app/modules/home/widgets/homeCustomFirst/home_custom_first_bloc.dart';
import 'package:franet/app/modules/home/widgets/homeCustomFirst/widgets/CardAcessoRapido/card_acesso_rapido_widget.dart';
import 'package:franet/app/modules/home/widgets/homeCustomFirst/widgets/IconsAcessRapid/icons_acess_rapid_widget.dart';
import 'package:franet/app/modules/invoices/invoices_module.dart';
import 'package:franet/app/modules/login/login_module.dart';
import 'package:franet/app/modules/notifications/notifications_module.dart';
import 'package:franet/app/modules/paymentPromise/paymentPromise_module.dart';
import 'package:franet/app/modules/support/support_module.dart';
import 'package:franet/app/modules/testVelocity/testVelocity_module.dart';
import 'package:franet/app/modules/tips/tips_module.dart';
import 'package:franet/app/modules/viewerPDF/viewerPDF_module.dart';
import 'package:intl/intl.dart';

HomeBloc homeBloc = HomeBloc();
HomeCustomFirstBloc homeCustomFirstBloc = HomeCustomFirstBloc();
var currencyFormatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

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
                    height: MediaQuery.of(context).size.height * 0.61,
                    child: Image.network(
                      imageFundo2,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fill,
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
                        Image.network(
                          paramImageLogo,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        IconButton(
                            onPressed: () {
                              if (contracts.length > 1) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChooseContractsModule(contracts)));
                              } else {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => LoginModule()));
                              }
                            },
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
                                    margin: EdgeInsets.only(left: 10, top: 15),
                                    child: Text(
                                      "Olá",
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
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    margin: EdgeInsets.only(left: 10, top: 5),
                                    child: Text("${FunctinsGlobals().getPrimeiroUltimoNome(snapshot.data["razaoSocial"])}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2)
                                            ])),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10, top: 5),
                                    child: Text(
                                      "Como podemos ajudar?",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Plano atual",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${snapshot.data["plano"]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Valor: ${currencyFormatter.format(snapshot.data["valor"])}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
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
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
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
                                                "Status do Serviço",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(snapshot.data["status"],
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: 
                                                FunctinsGlobals().retornaCorStatusServico(snapshot.data["status"])
                                                    // Colors.white
                                                    ),
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
                                                "Nº do Contrato",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${snapshot.data["contrato"]}",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 5, right: 5, top: 20),
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
                                      funcao: () =>
                                          homeCustomFirstBloc.abrirNovaTela(
                                              context, InvoicesModule()),
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/consumo.png",
                                      label: "Consumo de banda",
                                      funcao: () =>
                                          homeCustomFirstBloc.abrirNovaTela(
                                              context,
                                              ExtractConsumptionModule()),
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/propagamento.png",
                                      label: "Promessa de pagamento",
                                      funcao: () => homeCustomFirstBloc.abrirNovaTela(
                                          context, PaymentPromiseModule()),
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/suportenew.png",
                                      label: "Suporte",
                                      funcao: () =>
                                          homeCustomFirstBloc.abrirNovaTela(
                                              context, SupportModule()),
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/velocidade.png",
                                      label: "Teste de velocidade",
                                      funcao: () =>
                                          homeCustomFirstBloc.abrirNovaTela(
                                              context, TestVelocityModule()),
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/notification.png",
                                      label: "Notificações",
                                      funcao: () =>
                                          homeCustomFirstBloc.abrirNovaTela(
                                              context, NotificationsModule()),
                                    ),
                                    CardAcessoRapidoWidget(
                                      iconeCustom: paramIconesCustom,
                                      urlIcone: "images/dicas.png",
                                      label: "Dicas",
                                      funcao: () => homeCustomFirstBloc
                                          .abrirNovaTela(context, TipsModule()),
                                    ),
                                    CardAcessoRapidoWidget(
                                        iconeCustom: paramIconesCustom,
                                        urlIcone: "images/contrato.png",
                                        label: "Contrato",
                                        funcao: () =>
                                            homeCustomFirstBloc.abrirNovaTela(
                                                context, ViewerPDFModule(paramurlcontratoscm))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconsAcessRapidWidget(
                                      icone: Icons.phone,
                                      exibe: paramIconesUse['telefones'],
                                      urlLauncher: paramTelefonePrincipal,
                                    ),
                                    IconsAcessRapidWidget(
                                      icone: FontAwesomeIcons.whatsapp,
                                      exibe: paramIconesUse['contatowhats'],
                                      urlLauncher: paramurlcontatowhats,
                                    ),
                                    IconsAcessRapidWidget(
                                      icone: FontAwesomeIcons.facebook,
                                      exibe: paramIconesUse['facebook'],
                                      urlLauncher: paramFacebook,
                                    ),
                                    IconsAcessRapidWidget(
                                      icone: FontAwesomeIcons.instagram,
                                      exibe: paramIconesUse['instagram'],
                                      urlLauncher: paramInstagram,
                                    ),
                                    IconsAcessRapidWidget(
                                      icone: Icons.home,
                                      exibe: paramIconesUse['siteprovedor'],
                                      urlLauncher: paramsiteprovedor,
                                    ),
                                  ],
                                ),
                              )
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
