import 'package:flutter/material.dart';
import 'package:flutter_native_html_view/flutter_native_html_view.dart';
import 'package:franet/app/modules/paymentPromise/paymentPromise_bloc.dart';

class PaymentPromisePage extends StatefulWidget {
  final String title;
  const PaymentPromisePage({Key key, this.title = "Promessa de Pagamento"})
      : super(key: key);

  @override
  _PaymentPromisePageState createState() => _PaymentPromisePageState();
}

PaymentPromiseBloc paymentPromiseBloc = PaymentPromiseBloc();

class _PaymentPromisePageState extends State<PaymentPromisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: paymentPromiseBloc.verifyContractsStatus(),
              builder: (context, snapshot) {
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
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  );
                }
                if (snapshot.data["statusSupenso"] == true) {
                  // contrato está suspenso
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "images/cpfcnpj.png",
                                width: MediaQuery.of(context).size.width / 2.9,
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Nome/Razão Social",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 3, left: 5, bottom: 5),
                                      child: Text(
                                        snapshot.data["razaosocial"],
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600]),
                                      )),
                                  Text(
                                    "Numero do Contrato",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 3, left: 5, bottom: 5),
                                      child: Text(
                                        snapshot.data["contrato"].toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600]),
                                      )),
                                  Text(
                                    "Status do Contrato",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 3, left: 5, bottom: 5),
                                      child: Text(
                                        snapshot.data["status"],
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600]),
                                      )),
                                  Text(
                                    "Plano Contratado",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 3, left: 5),
                                      child: Text(
                                        snapshot.data["planoInternet"],
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600]),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Image.asset(
                          "images/alerta.png",
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: FlutterNativeHtmlView(
                              htmlData: snapshot.data["param_txtpromessapag"],
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        StreamBuilder(
                          initialData: false,
                          stream: paymentPromiseBloc.outputButton,
                          builder: (context, snapshots) {
                            return Container(
                              margin: EdgeInsets.only(top: 20),
                              child: AnimatedCrossFade(
                                crossFadeState: snapshots.data
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(seconds: 1),
                                firstChild: ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 1.4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                  child: RaisedButton(
                                      child: Text(
                                        "Realizar Promessa de Pagamento",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        paymentPromiseBloc.animacaoButton(true);
                                        await paymentPromiseBloc
                                            .paymentPromise(
                                                snapshot.data["cpfCnpj"],
                                                snapshot.data["senha"],
                                                snapshot.data["contrato"],
                                                snapshot.data["baseUrl"])
                                            .then((onValue) {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text("$onValue"),
                                          ));
                                        });
                                        paymentPromiseBloc
                                            .animacaoButton(false);
                                      }),
                                ),
                                secondChild: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  margin: EdgeInsets.only(top: 0, bottom: 10),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/pago.png",
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: FlutterNativeHtmlView(
                           /* defaultTextStyle: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),*/
                            htmlData: snapshot.data["param_txtpromessapagok"],
                          )),
                    ],
                  ),
                );
              }),
        ));
  }
}
