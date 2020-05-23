import 'package:franet/app/modules/login/dialogs/dialog_tipo_pessoa.dart';
import 'package:flutter/material.dart';

Future<void> mensagemChooseCidadeProvedor(
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
                                            Text(conteudo[index]["app_city"],
                                                style: TextStyle(fontSize: 25)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                        child:
                                            Icon(Icons.keyboard_arrow_right)),
                                  ],
                                ),
                                onTap: () async {
                                  Navigator.pop(context);
                                  await mensagemChooseTipoPessoa(
                                      context,
                                      [
                                        {
                                          "url": conteudo[index]
                                              ["app_precadastropj"],
                                          "tipo": "Pessoa Juridica"
                                        },
                                        {
                                          "url": conteudo[index]
                                              ["app_precadastropf"],
                                          "tipo": "Pessoa Fisica"
                                        }
                                      ],
                                      "Escolha o seu tipo");
                                  //   "pessoa juridica ${conteudo[index]["app_precadastropj"]}");
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
                  FlatButton(
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
