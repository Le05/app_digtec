import 'package:flutter/material.dart';
import 'package:franet/app/modules/tips/tips_bloc.dart';

class TipsPage extends StatefulWidget {
  final String title;
  const TipsPage({Key key, this.title = "Dicas"}) : super(key: key);

  @override
  _TipsPageState createState() => _TipsPageState();
}

TipsBloc tipsBloc = TipsBloc();

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: FutureBuilder(
              future: tipsBloc.getTips(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Ocorreu um erro ao buscar as dicas!!!"));
                }
                return GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                              color: snapshot.data[index]["color"],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  margin: EdgeInsets.only(top: 15),
                                  child: Center(
                                    child: Text(
                                        snapshot.data[index]["dicas_title"],style: TextStyle(fontWeight: FontWeight.bold),),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                margin: EdgeInsets.only(top: 10),
                                child: Text(snapshot.data[index]["dicas_desc"],style: TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ));
                    });
              }),
        ));
  }
}
