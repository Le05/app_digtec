import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franet/app/modules/invoices/invoices_bloc.dart';
import 'package:franet/app/modules/invoices/widgets/invoicesNotPaid/invoicesNotPaid_bloc.dart';

InvoicesBloc invoicesBloc = InvoicesBloc();

class InvoicesNotPaidWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: invoicesBloc.getInvoices(),
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
          return ListView.builder(
            itemCount: snapshot.data["titlesAberta"].length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Data do Vencimento: ",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "${snapshot.data["titlesAberta"][index].vencimento}",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Valor: ",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text("R\$${snapshot.data["titlesAberta"][index].valor.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 35, top: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "images/copiar.png",
                          width: MediaQuery.of(context).size.width / 9,
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Numero do Documento",
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                            Text(
                                "${snapshot.data["titlesAberta"][index].numeroDocumento}",
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 35, top: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "images/data.png",
                          width: MediaQuery.of(context).size.width / 9,
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Data do Vencimento",
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                            Text(
                                "${snapshot.data["titlesAberta"][index].vencimento}",
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 35, top: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "images/devendo.png",
                          width: MediaQuery.of(context).size.width / 9,
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Valor",
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                            Text(
                                "R\$${snapshot.data["titlesAberta"][index].valor.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 35,
                        top: 10,
                        bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "images/codigobarra.png",
                          width: MediaQuery.of(context).size.width / 9,
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.19,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Codigo de Barra",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                              Text(
                                  "${snapshot.data["titlesAberta"][index].linhaDigitavel}",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      /*SizedBox(
                        width: MediaQuery.of(context).size.width / 9,
                        height: MediaQuery.of(context).size.height / 20,
                      ),*/
                      ButtonTheme(
                        child: RaisedButton(
                          child: Text(
                            "Visualizar Boleto",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Abrindo navegador..."),
                            ));
                            try {
                              await InvoicesNotPaidBloc().launchPDF(
                                  "${snapshot.data["titlesAberta"][index].link}");
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("$e"),
                              ));
                            }
                          },
                        ),
                      ),
                      //SizedBox(width: 20,),
                      ButtonTheme(
                        child: RaisedButton(
                          child: Text(
                            "Copiar codigo",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: snapshot.data["titlesAberta"][index]
                                    .linhaDigitavel));
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Código copiado com sucesso!!!"),
                            ));
                          },
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
