import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentCreditCardExternalPage extends StatefulWidget {
  final String title;
  final String url;
  const PaymentCreditCardExternalPage(
      {Key key, this.title = "PaymentCreditCardExternal",this.url})
      : super(key: key);

  @override
  _PaymentCreditCardExternalPageState createState() =>
      _PaymentCreditCardExternalPageState();
}

class _PaymentCreditCardExternalPageState
    extends State<PaymentCreditCardExternalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: this.widget.url,
          ),
        ));
  }
}
