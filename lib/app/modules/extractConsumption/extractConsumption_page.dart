import 'package:flutter/material.dart';

class ExtractConsumptionPage extends StatefulWidget {
  final String title;
  const ExtractConsumptionPage({Key key, this.title = "ExtractConsumption"})
      : super(key: key);

  @override
  _ExtractConsumptionPageState createState() => _ExtractConsumptionPageState();
}

class _ExtractConsumptionPageState extends State<ExtractConsumptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
