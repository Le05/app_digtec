import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/home/widgets/propaganda/propaganda_bloc.dart';

PropagandaBloc propagandaBloc = PropagandaBloc();

class PropagandaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: FutureBuilder(
            future: propagandaBloc.getPropaganda(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Text("Ocorreu um erro ao buscar as propagandas"),
                  ),
                );
              }
              if (snapshot.data["exibe"] == false) {
                return Container();
              }
              return Column(
                children: <Widget>[
                  snapshot.data["param_propagandatitulo"] != null &&
                          snapshot.data["param_propagandatitulo"] != ""
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Text(
                              snapshot.data["param_propagandatitulo"],
                              style:
                                  TextStyle(fontSize: 20, color: Theme.of(context).textTheme.headline3.color),
                            ),
                          ),
                        )
                      : Container(),
                  CarouselSlider.builder(
                    viewportFraction: 1.0,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlay: true,
                    itemCount: snapshot.data["propaganda"].length,
                    height: MediaQuery.of(context).size.height / 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            "${snapshot.data["propaganda"][index]["ads_image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            }));
  }
}
