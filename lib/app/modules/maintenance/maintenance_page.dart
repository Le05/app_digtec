import 'package:flutter/material.dart';

class MaintenancePage extends StatefulWidget {
  final String title;
  const MaintenancePage({Key key, this.title = "Maintenance"})
      : super(key: key);

  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
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
