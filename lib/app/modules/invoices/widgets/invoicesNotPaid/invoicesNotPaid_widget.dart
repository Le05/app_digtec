import 'package:flutter/material.dart';
import 'package:franet/app/modules/invoices/invoices_bloc.dart';

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
              return Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.03,
                            child: Center(
                              child: Text(
                                "Data do Vencimento: ${snapshot.data["titlesAberta"][index].vencimento}",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Status do Pagamento ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${snapshot.data["titlesAberta"][index].status}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Data do Vencimento ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${snapshot.data["titlesAberta"][index].vencimento}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Valor do Pagamento ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "R\$${snapshot.data["titlesAberta"][index].valor.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Data do Pagamento ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
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
