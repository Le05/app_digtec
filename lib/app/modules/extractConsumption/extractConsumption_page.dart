import 'package:flutter/material.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_bloc.dart';
import 'package:franet/app/modules/extractConsumption/widgets/ConsumptioImages/ConsumptioImages_widget.dart';
import 'package:franet/app/modules/extractConsumption/widgets/Consumption/Consumption_widget.dart';


class ExtractConsumptionPage extends StatefulWidget {
  final String title;
  const ExtractConsumptionPage({Key key, this.title = "Consumo"})
      : super(key: key);

  @override
  _ExtractConsumptionPageState createState() => _ExtractConsumptionPageState();
}

ExtractConsumptionBloc extractConsumptionBloc = ExtractConsumptionBloc();
PageController pageController = PageController();

class _ExtractConsumptionPageState extends State<ExtractConsumptionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                paramExibirGraficoConsumo == "1" ?
                Container(
                 // width: MediaQuery.of(context).size.width,
                //  height: MediaQuery.of(context).size.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                            child: Text(
                              "Consumo",
                              style: TextStyle(
                                  fontSize: 16, color: corfontebuttonhome),
                            ),
                            onPressed: () {
                              pageController.jumpToPage(0);
                            }),
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                            child: Text(
                              "Gráficos",
                              style: TextStyle(
                                  fontSize: 16, color: corfontebuttonhome),
                            ),
                            onPressed: () {
                              pageController.jumpToPage(1);
                            }),
                      )
                    ],
                  ),
                ):Container(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    controller: pageController,
                    children: <Widget>[
                      ConsumptionWidget(),
                      ConsumptioImagesWidget()
                      
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
