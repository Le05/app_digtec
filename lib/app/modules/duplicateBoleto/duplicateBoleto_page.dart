import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franet/app/modules/duplicateBoleto/duplicateBoleto_bloc.dart';

class DuplicateBoletoPage extends StatefulWidget {
  final String title;
  const DuplicateBoletoPage({Key key, this.title = "2° via da Fatura"})
      : super(key: key);

  @override
  _DuplicateBoletoPageState createState() => _DuplicateBoletoPageState();
}

class _DuplicateBoletoPageState extends State<DuplicateBoletoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: DuplicateBoletoBloc().getDados2Via(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.green),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Ocorreu um erro ao obter os dados"),
                    );
                  }
                  if (snapshot.data["links"].length == 0) {
                    // se nao tiver links, significa que não existe nada para exibir
                    return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Não existe segunda via para ser exibida!!",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              "images/semSegundaVia.png",
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 2.1,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 40,
                                  ),
                                  child: Text(
                                    "${snapshot.data["razaosocial"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 30,
                                    left:
                                        MediaQuery.of(context).size.width / 50),
                                child: Row(children: <Widget>[
                                  Image.asset(
                                    "images/data.png",
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Data de Vencimento"),
                                      Text(
                                        "${snapshot.data["vencimento"]}",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )
                                ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 50,
                                    left:
                                        MediaQuery.of(context).size.width / 50),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "images/protocolo.png",
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Protocolo"),
                                        Text(
                                          "${snapshot.data["protocolo"]}",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 50,
                                    left:
                                        MediaQuery.of(context).size.width / 50),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "images/cpfcnpj.png",
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("CPF/CNPJ"),
                                        Text(
                                          "${snapshot.data["cpfcnpj"]}",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 50,
                                    left:
                                        MediaQuery.of(context).size.width / 50),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "images/codigobarra.png",
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Codigo de barra"),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.71,
                                            child: Text(
                                              "${snapshot.data["linhadigitavel"]}",
                                              style: TextStyle(fontSize: 12),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //copiar codigo de barras
                      //visualizar boletos
                      // enviar para o email
                      // enviar via sms
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 8,
                            right: MediaQuery.of(context).size.width / 8,
                            top: MediaQuery.of(context).size.height / 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3.1,
                              height: MediaQuery.of(context).size.height / 5.8,
                              child: InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  elevation: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/copiar.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 0),
                                          child:
                                              Text("Copiar codigo de barras"))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: snapshot.data["linhadigitavel"]));
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text("Código copiado com sucesso!!!"),
                                  ));
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.1,
                              height: MediaQuery.of(context).size.height / 5.8,
                              child: InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  elevation: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/visualizar.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                              right: 10),
                                          child: Text("Visualizar Boleto"))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  DuplicateBoletoBloc().launchPDF(
                                      snapshot.data["links"][0]["link"]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 8,
                            right: MediaQuery.of(context).size.width / 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3.1,
                              height: MediaQuery.of(context).size.height / 5.8,
                              child: InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  elevation: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/enviarEmail.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child:
                                              Text("Receber Fatura no Email"))
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  await DuplicateBoletoBloc()
                                      .postFatura2Via("email")
                                      .then((onValue) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(onValue["msg"]),
                                    ));
                                  }).catchError((onError) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(onError),
                                    ));
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.1,
                              height: MediaQuery.of(context).size.height / 5.8,
                              child: InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  elevation: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/sms.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text("Receber Fatura via SMS"))
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  await DuplicateBoletoBloc()
                                      .postFatura2Via("sms")
                                      .then((onValue) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(onValue["msg"]),
                                    ));
                                  }).catchError((onError) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(onError),
                                    ));
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
                },
              ),
            )
          ],
        ));
  }
}
