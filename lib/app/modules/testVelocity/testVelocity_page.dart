import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestVelocityPage extends StatefulWidget {
  final String title;
  const TestVelocityPage({Key key, this.title = "TestVelocity"})
      : super(key: key);

  @override
  _TestVelocityPageState createState() => _TestVelocityPageState();
}

class _TestVelocityPageState extends State<TestVelocityPage> {
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
            initialUrl: "https://franet.speedtestcustom.com/",
            
          ),
        ));
  }
}
