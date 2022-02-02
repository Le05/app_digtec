import 'package:flutter/material.dart';
import 'package:app_digtec/app/functionsGlobals/functionsGlobals.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';
import 'package:url_launcher/url_launcher.dart';

void exibirDialogo(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: AlertDialog(
          title: new Text("Telefones"),
          content: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                  itemCount: telefones.length,
                  itemBuilder: (context, item) {
                    if(telefones[item] == "")
                      return Container();
                      
                    return InkWell(
                      child: Container(
                        margin: EdgeInsets.only(bottom:20),
                        child: Row(
                          children: [Icon(Icons.phone), SizedBox(width:10),Text(telefones[item])],
                        ),
                      ),
                      onTap: () async {
                        await canLaunch("tel:${FunctinsGlobals().limparTelefonesMascara(telefones[item])}")
                            ? await launch("tel:${FunctinsGlobals().limparTelefonesMascara(telefones[item])}")
                            : throw 'Could not launch $telefones[item]';
                      },
                    );
                  })),
          actions: <Widget>[
            // define os botões na base do dialogo
            new TextButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
