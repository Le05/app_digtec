import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/invoices/invoices_bloc.dart';

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
            itemCount: snapshot.data["titlesPaga"].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: index == snapshot.data["titlesAberta"].length-1 ? 60 :5),
                child: Card(
                    elevation: 10,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5,top: MediaQuery.of(context).size.height / 80),
                          width: MediaQuery.of(context).size.width / 11,
                          height: MediaQuery.of(context).size.height / 15,
                          child: Image.asset("images/ok.png"),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      "Boleto: ${snapshot.data["titlesPaga"][index].id}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        "R\$ ${snapshot.data["titlesPaga"][index].valor.toStringAsFixed(2)}",
                                        style: TextStyle(fontSize: 15),
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
                                        "Vencimento: ${snapshot.data["titlesPaga"][index].vencimento}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      "${snapshot.data["titlesPaga"][index].status}",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                 margin: EdgeInsets.only(left: 10,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Data Pagamento: ${snapshot.data["titlesPaga"][index].dataPagamento}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
