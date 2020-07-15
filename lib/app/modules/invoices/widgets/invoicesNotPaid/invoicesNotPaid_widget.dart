import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/invoices/invoices_bloc.dart';
import 'package:franet/app/modules/invoices/widgets/invoicesNotPaid/invoicesNotPaid_bloc.dart';
import 'package:franet/app/modules/paymentCreditCard/paymentCreditCard_module.dart';

InvoicesBloc invoicesBloc = InvoicesBloc();
InvoicesNotPaidBloc invoicesNotPaidBloc = InvoicesNotPaidBloc();

class InvoicesNotPaidWidget extends StatefulWidget {
  @override
  _InvoicesNotPaidWidgetState createState() => _InvoicesNotPaidWidgetState();
}

class _InvoicesNotPaidWidgetState extends State<InvoicesNotPaidWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: FutureBuilder(
        future: invoicesBloc.getInvoices(),
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
          return ListView.builder(
            itemCount: snapshot.data["titlesAberta"].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 10,
                  child: ExpansionTile(
                    title: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          width: MediaQuery.of(context).size.width / 15,
                          height: MediaQuery.of(context).size.height / 15,
                          child: Image.asset("images/close.png"),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 11),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      "Boleto: ${snapshot.data["titlesAberta"][index].id}",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        "R\$${snapshot.data["titlesAberta"][index].valor.toStringAsFixed(2)}",
                                        style: TextStyle(fontSize: 17),
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Vencimento: ${snapshot.data["titlesAberta"][index].vencimento}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      "Aberto", // "${snapshot.data["titlesAberta"][index].status}",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              buttonColor: Color(0xFF5CB85C),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(color: Color(0xFF28a744))),
                              child: RaisedButton(
                                  child: Text(
                                    "Copiar Código de Barras",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: snapshot
                                            .data["titlesAberta"][index]
                                            .linhaDigitavel));
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text("Código copiado com sucesso!!!"),
                                    ));
                                  }),
                            ),
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              buttonColor: Color(0xFF5BC0DE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(color: Color(0xFF34B4E5))),
                              child: RaisedButton(
                                  child: Text(
                                    "Visualizar ou Imprimir o Boleto",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    invoicesNotPaidBloc.launchPDF(snapshot
                                        .data["titlesAberta"][index].link);
                                  }),
                            ),
                            paymentCardcredit == "1"
                                ? ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width,
                                    buttonColor: Color(0xFFf0ad4e),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        side: BorderSide(
                                            color: Color(0xFFffc106))),
                                    child: RaisedButton(
                                        child: Text(
                                          "Pagamento com Cartão de Crédito",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          fatura = snapshot.data["titlesAberta"]
                                              [index].id;
                                         var retorno = Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentCreditCardModule()));
                                                      setState(() {
                                                        
                                                      });
                                        }),
                                  )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
