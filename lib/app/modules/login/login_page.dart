import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:franet/app/app_module.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/login/dialogs/dialog_cidades.dart';
import 'package:franet/app/modules/login/dialogs/dialog_tipo_pessoa.dart';
import 'package:franet/app/modules/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

LoginBloc loginBloc = LoginBloc();
final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: loginBloc.verifyInternetAndBox(),
            builder: (context, snapshot) {
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
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: InkWell(
                            child: Text(
                              "Tente novamente",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 17),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppModule()));
                            }),
                      )
                    ],
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                decoration: corFundoBackgroundExibir == "0" ? BoxDecoration(
                  color: Colors.white
                ):BoxDecoration(
                  color: corFundoBackground
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                        decoration: corFundoLogoTipoExibir == "0"
                            ? BoxDecoration()
                            : BoxDecoration(
                              color: corFundoLogoTipo,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(70))
                            ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: FutureBuilder(
                            future: loginBloc.getImageLogin(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Container(
                                  margin: EdgeInsets.only(
                                      left: paramlogotipomarginleft,
                                      right: paramlogotipomarginright),
                                  child: Image.file(snapshot.data.file));
                            })),
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: FutureBuilder(
                                  future: loginBloc.getSaveLogin(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return Container(
                                        child: Text(
                                            "Ocorreu um erro ao acessar os parametros"),
                                      );
                                    }
                                    return TextFormField(
                                      controller: snapshot.data,
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      decoration: InputDecoration(
                                          hintText: "CPF/CNPJ Ex:42236545852",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)))),
                                      validator: (text) {
                                        if (text.isEmpty)
                                          return "Por Favor,insira um CPF/CNPJ!!";
                                        else if (text.length > 14)
                                          return "Por Favor,insira um CPF/CNPJ válido!!";
                                        else if (text.length < 11)
                                          return "Por Favor,insira um CPF/CNPJ válido!!";
                                        return null;
                                      },
                                    );
                                  }),
                            ),
                            FutureBuilder(
                                future: loginBloc.getpassword(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Container(
                                      child: Text(
                                          "Ocorreu um erro ao acessar os parametros"),
                                    );
                                  }
                                  if (snapshot.data["param_senha"] == "1") {
                                    loginBloc.senhaController.text =
                                        snapshot.data["param_senhapadrao"];
                                    return Container();
                                  }
                                  if (snapshot.data["param_senhapadrao"] ==
                                      null) {
                                    loginBloc.senhaController.text =
                                        snapshot.data["senha"];
                                  }
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: TextFormField(
                                      controller: loginBloc.senhaController,
                                      decoration: InputDecoration(
                                          hintText: "Senha",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)))),
                                      validator: (text) {
                                        if (text.isEmpty)
                                          return "Por Favor,insira a senha!!";
                                        return null;
                                      },
                                      obscureText: true,
                                    ),
                                  );
                                }),
                            StreamBuilder(
                                initialData: false,
                                stream: loginBloc.outputCheckScwitch,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Container(
                                      child: Text(
                                          "Ocorreu um erro ao acessar os parametros"),
                                    );
                                  }
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Switch(
                                            value: snapshot.data,
                                            onChanged: (value) {
                                              loginBloc.checkScwitch(value);
                                            }),
                                        Text("Lembrar-me CPF/CNPJ",style: TextStyle(color: corfontehome == null ? Colors.black : corfontehome),)
                                      ],
                                    ),
                                  );
                                }),
                            StreamBuilder(
                              initialData: false,
                              stream: loginBloc.outputLogin,
                              builder: (context, snapshot) {
                                return Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: AnimatedCrossFade(
                                    crossFadeState: snapshot.data
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: Duration(seconds: 1),
                                    firstChild: ButtonTheme(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      minWidth:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      child: RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          "Entrar",
                                          style: TextStyle(
                                              color: corfontebuttonhome == null ? Colors.black : corfontebuttonhome,
                                              fontSize: 16),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            loginBloc.animacaoLogin(true);
                                            await loginBloc
                                                .loginUser(context)
                                                .then((onValue) {
                                              if (onValue == 3) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Não foi encontrado nenhum contrato referente a este CPF/CNPJ !!"),
                                                ));
                                              } else if (onValue == 1) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Ocorreu um erro ao logar, verique as credenciais e internet!!"),
                                                ));
                                              }
                                            });
                                            loginBloc.animacaoLogin(false);
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeModule()));
                                          }
                                        },
                                      ),
                                    ),
                                    secondChild: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      margin:
                                          EdgeInsets.only(top: 0, bottom: 10),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        25),
                                child: InkWell(
                                  child: Html(
                                    data: parammsgprecadastro,
                                    defaultTextStyle: TextStyle(fontSize: 17),
                                    customTextAlign: (element) {
                                      return TextAlign.center;
                                    },
                                  ),
                                  onTap: () async {
                                    if (preCadastros.length == 1) {
                                      await mensagemChooseTipoPessoa(
                                          context,
                                          [
                                            {
                                              "url": preCadastros[0]
                                                  ["app_precadastropj"],
                                              "tipo": "Pessoa Juridica"
                                            },
                                            {
                                              "url": preCadastros[0]
                                                  ["app_precadastropf"],
                                              "tipo": "Pessoa Fisica"
                                            }
                                          ],
                                          "Escolha o seu tipo");
                                    } else {
                                      await mensagemChooseCidadeProvedor(
                                        context,
                                        preCadastros,
                                        "Escolha a sua localização",
                                      );
                                    }
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
