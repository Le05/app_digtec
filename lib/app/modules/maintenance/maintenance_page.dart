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
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: Image.asset(
                "images/manutencao.png",
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
             margin:
                  EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                  "Estamos fazendo manutenção em nossos servidores para melhor atende-lo, voltaremos em breve!!!",
                  style: TextStyle(fontSize: 20),),
            ),
          )
        ],
      ),
    );
  }
}
