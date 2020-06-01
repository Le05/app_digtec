import 'package:flutter/material.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/invoices/widgets/invoicesNotPaid/invoicesNotPaid_widget.dart';
import 'package:franet/app/modules/invoices/widgets/invoicesPaid/invoicesPaid_widget.dart';

class InvoicesPage extends StatefulWidget {
  final String title;
  const InvoicesPage({Key key, this.title = "Faturas"}) : super(key: key);

  @override
  _InvoicesPageState createState() => _InvoicesPageState();
}

PageController pageController = PageController();

class _InvoicesPageState extends State<InvoicesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            /* bottom: TabBar(
            tabs: <Widget>[
             Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/devendo.png",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Não pagas",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/pago.png"),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Pagas",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              )
            ],
          ),*/
            title: Text(widget.title),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                 // width: MediaQuery.of(context).size.width,
                //  height: MediaQuery.of(context).size.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 3,
                        child: RaisedButton(
                            child: Text(
                              "Não Pagas",
                              style: TextStyle(
                                  fontSize: 16, color: corfontebuttonhome),
                            ),
                            onPressed: () {
                              pageController.jumpToPage(1);
                            }),
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 3,
                        child: RaisedButton(
                            child: Text(
                              "Pagas",
                              style: TextStyle(
                                  fontSize: 16, color: corfontebuttonhome),
                            ),
                            onPressed: () {
                              pageController.jumpToPage(0);
                            }),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    controller: pageController,
                    children: <Widget>[
                      InvoicesPaidWidget(),
                      InvoicesNotPaidWidget(),
                      
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
