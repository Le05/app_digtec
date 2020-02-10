import 'package:flutter/material.dart';
import 'package:franet/app/modules/support/support_bloc.dart';

class SupportPage extends StatefulWidget {
  final String title;
  const SupportPage({Key key, this.title = "Suporte"}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

final _formKey = GlobalKey<FormState>();
SupportBloc supportBloc = SupportBloc();

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, bottom: 20),
              child: Text(
                "Leia aqui antes de Prosseguir",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  "images/internet.png",
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 5.5,
                ),
                FutureBuilder(
                    future: supportBloc.getTxtOs(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 5,
                        child: Text(
                          snapshot.data,
                          style: TextStyle(fontSize: 17),
                        ),
                      );
                    })
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 15, bottom: 20),
              child: Text(
                "Telefones para Contato",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Container();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "images/telefone.png",
                            width: MediaQuery.of(context).size.width / 12,
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            snapshot.data["param_telprincipal"],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "images/telefone.png",
                            width: MediaQuery.of(context).size.width / 12,
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            snapshot.data["param_telsecundario"],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "images/whatsapp.png",
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data["param_telwhats"],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        //supportBloc.openWhatsApp(telefone);
                      },
                    ),
                  ],
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 30,
              ),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          maxLength: 11,
                          controller: supportBloc.contatoController,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              hintText: "Telefone para Contato",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (text) {
                            if (text.isEmpty)
                              return "Por Favor,insira um contato";
                            else if (text.length < 9)
                              return "Por Favor,insira um contato válido!!";
                            // else if (text.length < 11)
                            // return "Por Favor,insira um CPF/CNPJ válido!!";
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          maxLines: 5,
                          controller: supportBloc.conteudoController,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintText: "Motivos",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                          validator: (text) {
                            if (text.isEmpty)
                              return "Por Favor,insira um motivo!";
                            return null;
                          },
                        ),
                      ),
                    ],
                  )),
            ),
            StreamBuilder(
              initialData: false,
              stream: supportBloc.outputanimacaoButton,
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: AnimatedCrossFade(
                    crossFadeState: snapshot.data
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(seconds: 1),
                    firstChild: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: RaisedButton(
                          child: Text(
                            "Solicitar Suporte",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          onPressed: () async {
                            supportBloc.animacaoButton(true);
                            if (_formKey.currentState.validate()) {
                              await supportBloc.openCall().then((onValue) {
                                if (onValue["status"] == 0) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(onValue["msg"]),
                                  ));
                                }
                                if (onValue["status"] == 3) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(onValue["msg"]),
                                  ));
                                }
                                if (onValue["status"] == 1) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(onValue["msg"]),
                                  ));
                                }
                              });
                            }
                            supportBloc.animacaoButton(false);
                          }),
                    ),
                    secondChild: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 15,
                      margin: EdgeInsets.only(top: 0, bottom: 10),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
