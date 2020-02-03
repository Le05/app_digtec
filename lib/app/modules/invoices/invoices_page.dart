import 'package:flutter/material.dart';
import 'package:franet/app/modules/invoices/widgets/invoicesNotPaid/invoicesNotPaid_widget.dart';
import 'package:franet/app/modules/invoices/widgets/invoicesPaid/invoicesPaid_widget.dart';

class InvoicesPage extends StatefulWidget {
  final String title;
  const InvoicesPage({Key key, this.title = "Faturas"}) : super(key: key);

  @override
  _InvoicesPageState createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
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
          ),
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: <Widget>[InvoicesNotPaidWidget(), InvoicesPaidWidget()],
        ),
      ),
    );
  }
}
