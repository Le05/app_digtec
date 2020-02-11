import 'package:flutter/material.dart';
import 'package:franet/app/modules/invoices/invoices_bloc.dart';

InvoicesBloc invoicesBloc = InvoicesBloc();

class InvoicesPaidWidget extends StatelessWidget {
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
            itemCount: snapshot.data["titlesPaga"].length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Data do Pagamento: ",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "${snapshot.data["titlesPaga"][index].dataPagamento}",
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
                        Text("${snapshot.data["titlesPaga"][index].valor}",
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
                                "${snapshot.data["titlesPaga"][index].numeroDocumento}",
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
                                "${snapshot.data["titlesPaga"][index].vencimento}",
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
                            Text("${snapshot.data["titlesPaga"][index].valor}",
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
                          "images/data.png",
                          width: MediaQuery.of(context).size.width / 9,
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Data do Pagamento",
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                            Text(
                                "${snapshot.data["titlesPaga"][index].dataPagamento}",
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
