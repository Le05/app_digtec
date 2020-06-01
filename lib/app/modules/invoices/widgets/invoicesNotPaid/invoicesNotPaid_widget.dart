import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franet/app/modules/invoices/invoices_bloc.dart';
import 'package:franet/app/modules/invoices/widgets/invoicesNotPaid/invoicesNotPaid_bloc.dart';

InvoicesBloc invoicesBloc = InvoicesBloc();
InvoicesNotPaidBloc invoicesNotPaidBloc = InvoicesNotPaidBloc();

class InvoicesNotPaidWidget extends StatelessWidget {
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
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10,top: 10),
                            child: Text(
                              "Boleto: ${snapshot.data["titlesAberta"][index].id} - ${snapshot.data["titlesAberta"][index].vencimento}",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                  "R\$${snapshot.data["titlesAberta"][index].valor}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                                "${snapshot.data["titlesAberta"][index].status}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 17),)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ButtonTheme(
                              child: RaisedButton(
                                  child: Text(
                                    "Copiar cod. de Barras",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {}),
                            ),
                            ButtonTheme(
                              child: RaisedButton(
                                  child: Text(
                                    "Visualizar Boleto",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {}),
                            ),
                            ButtonTheme(
                              child: RaisedButton(
                                  child: Text(
                                    "Pag. Cartão",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {}),
                            ),
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
