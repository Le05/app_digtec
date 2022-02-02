import 'package:app_digtec/app/modules/precadastro/precadastro_module.dart';
import 'package:flutter/material.dart';

Future<void> mensagemChooseTipoPessoa(
    BuildContext context, List conteudo, String titulo) async {
  //await Future.delayed(Duration(seconds: 1));
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(child: Text(titulo)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 1.5,
                child: ListView.builder(
                    itemCount: conteudo.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(left: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width / 1.5,
                          //height: 30,
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(conteudo[index]["tipo"]),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                        child:
                                            Icon(Icons.keyboard_arrow_right)),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PrecadastroModule(
                                                  conteudo[index]["url"],
                                                  conteudo[index]["tipo"])));
                                },
                              ),
                            ],
                          ));
                    }),
              ),
              /*Divider(
                color: Colors.white,
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: Text('Voltar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
