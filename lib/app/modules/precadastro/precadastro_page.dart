import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrecadastroPage extends StatefulWidget {
  final String title;
  final String url;
  final String tipo;
  const PrecadastroPage(
      {Key key, this.title = "Cadastro de", this.url, this.tipo})
      : super(key: key);

  @override
  _PrecadastroPageState createState() => _PrecadastroPageState();
}

class _PrecadastroPageState extends State<PrecadastroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.title} ${widget.tipo}"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
          ),
        ));
  }
}
