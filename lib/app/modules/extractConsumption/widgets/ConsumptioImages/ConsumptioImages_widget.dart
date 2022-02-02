import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/extractConsumption/widgets/ConsumptioImages/ConsumptioImages_bloc.dart';

ConsumptioImagesBloc consumptioImagesBloc = ConsumptioImagesBloc();

class ConsumptioImagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
          future: consumptioImagesBloc.buscarConsumoImages(),
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
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text("Verique sua conexão para acessar o app",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ],
                ),
              );
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 30,
                    decoration: BoxDecoration(color: Colors.green[200]),
                    child: Center(
                      child: Text(
                        "Consumo Diário",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.network(
                        "${consumptioImagesBloc.url}/media/img/rrdimg/${snapshot.data["login"]}-day.png"),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(color: Colors.green[200]),
                    child: Center(
                      child: Text(
                        "Consumo Mensal",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.network(
                        "${consumptioImagesBloc.url}/media/img/rrdimg/${snapshot.data["login"]}-month.png"),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(color: Colors.green[200]),
                    child: Center(
                      child: Text(
                        "Consumo Anual",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.network(
                        "${consumptioImagesBloc.url}/media/img/rrdimg/${snapshot.data["login"]}-year.png",
                        fit: BoxFit.contain,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                  )
                ],
              ),
            );
          }),
    ));
  }
}
