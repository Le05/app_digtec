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
                    fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  "images/internet.png",
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 5.5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Text(
                    "Antes de abrir um chamado,certifique-se que a entrada WAN do seu roteador está ligada(A entrada fica em destaque atrás do seu roteador) se estiver, retire seu roteador da energia por cerca de 2 minutos, se ao religar os problema persistir, solicite o suporte preenchendo os campos abaixos",
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15, bottom: 20),
              child: Text(
                "Telefones para Contato",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
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
                        "0800 6482329",
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
                        "3547-2062",
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
                          "991628798",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
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
                      // controller: loginBloc.cpfCnpjController,
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
                      //controller: loginBloc.cpfCnpjController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: "Motivos",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (text) {
                        if (text.isEmpty) return "Por Favor,insira um motivo!";
                        return null;
                      },
                    ),
                  ),
                ],
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ButtonTheme(
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
                      if(_formKey.currentState.validate()){
                        await supportBloc.openCall();
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
