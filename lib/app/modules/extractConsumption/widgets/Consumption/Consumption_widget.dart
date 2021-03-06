import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/extractConsumption/widgets/Consumption/Consumption_bloc.dart';

ConsumptionBloc consumptionBloc = ConsumptionBloc();

class ConsumptionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).size.height / 40),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: consumptionBloc.dataConsumoController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: "Data de Consumo",
                        hintText: "Digite a data",
                        labelStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Por Favor, Insira uma Data!!";
                      }
                      return null;
                    },
                    onTap: () async {
                      await consumptionBloc.selectDate(context);
                    },
                  ),
                ),
              ),
              onTap: () async {
                await consumptionBloc.selectDate(context);
              },
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 1.7,
                  top: MediaQuery.of(context).size.height / 40),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 15,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0)))),
                    child: Text(
                      "Consultar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      consumptionBloc.buscaConsumo();
                    }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
              child: StreamBuilder(
                  stream: consumptionBloc.outputConsumo,
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
                              "Parece que voc?? est?? sem internet!",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Text("Verique sua conex??o para acessar o app",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                      );
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width / 2.5),
                              child: Text(
                                  "Consumo de Tr??fego Total ${filesize(snapshot.data["total"])}")),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data["list"].length,
                                itemBuilder: (context, index) {
                                  return Container(                                    
                                    margin: EdgeInsets.only(
                                        top: 10, left: 10, right: 10,bottom: index == snapshot.data["list"].length-1 ? 80 :5),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.green[200],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "IP: ${snapshot.data["list"][index]["ip"]}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              "Download: ${filesize(snapshot.data["list"][index]["download"])}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              "Conectou: ${snapshot.data["list"][index]["dataini"]}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              "Horario: ${snapshot.data["list"][index]["horarioini"]}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              "Total de Tr??fego: ${filesize(snapshot.data["list"][index]["total"])}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "MAC: ${snapshot.data["list"][index]["mac"]}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              "Upload: ${filesize(snapshot.data["list"][index]["upload"])}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              snapshot.data["list"][index]
                                                          ["datafim"] !=
                                                      null
                                                  ? "Desconectou: ${snapshot.data["list"][index]["datafim"]}"
                                                  : "Desconectou: -",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              snapshot.data["list"][index]
                                                          ["horariofim"] !=
                                                      null
                                                  ? "Horario: ${snapshot.data["list"][index]["horariofim"]}"
                                                  : "Horario: -",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
