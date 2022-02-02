import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/tips/tips_bloc.dart';
import 'package:app_digtec/app/modules/tips/widgets/moreTips/moreTips_widget.dart';

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
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 5,
                        color: Colors.grey,
                      );
                    },
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.15,
                                  margin: EdgeInsets.only(top: 15),
                                  child: Text(
                                    snapshot.data[index]["dicas_title"],
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                /*Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2.5,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                          snapshot.data[index]["dicas_desc"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )*/

                                Container(
                                  child: Icon(Icons.chevron_right),
                                ),
                              ],
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoreTipsWidget(
                                      widget.key, snapshot.data[index])));
                        },
                      );
                    });
              }),
        ));
  }
}
