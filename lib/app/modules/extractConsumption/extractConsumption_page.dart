import 'package:flutter/material.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_bloc.dart';

class ExtractConsumptionPage extends StatefulWidget {
  final String title;
  const ExtractConsumptionPage({Key key, this.title = "Consumo"})
      : super(key: key);

  @override
  _ExtractConsumptionPageState createState() => _ExtractConsumptionPageState();
}

ExtractConsumptionBloc extractConsumptionBloc = ExtractConsumptionBloc();

class _ExtractConsumptionPageState extends State<ExtractConsumptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: MediaQuery.of(context).size.height / 40),
              child: TextFormField(
                controller: extractConsumptionBloc.dataConsumoController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: "Data de Consumo",
                    hintText: "Digite a data",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
                validator: (text) {
                  if (text.isEmpty) {
                    return "Por Favor, Insira uma Data!!";
                  }
                  return null;
                },
                onTap: () async {
                  await extractConsumptionBloc.selectDate(context);
                  extractConsumptionBloc.buscaConsumo();
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
              child: StreamBuilder(
                  stream: extractConsumptionBloc.outputConsumo,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center();
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Text("Verique sua conexão para acessar o app",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data["list"].length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left:10,right:10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.green[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("IP: ${snapshot.data["list"][index]["ip"]}",style: TextStyle(fontSize: 16),),
                                    Text("Download: ${snapshot.data["list"][index]["download"]}",style: TextStyle(fontSize: 16),),
                                    Text("Total de Tráfego: ${snapshot.data["list"][index]["total"]}",style: TextStyle(fontSize: 16),),
                                    Text("Conectou: ${snapshot.data["list"][index]["dataini"]}",style: TextStyle(fontSize: 16),),
                                    Text("Horario: ${snapshot.data["list"][index]["horarioini"]}",style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("MAC: ${snapshot.data["list"][index]["mac"]}",style: TextStyle(fontSize: 16),),
                                    Text("Upload: ${snapshot.data["list"][index]["upload"]}",style: TextStyle(fontSize: 16),),
                                    Text("Desconectou: ${snapshot.data["list"][index]["datafim"]}",style: TextStyle(fontSize: 16),)
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
