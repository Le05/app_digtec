import 'package:flutter/material.dart';
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(70))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: loginBloc.cpfCnpjController,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              hintText: "CPF/CNPJ Ex:42236545852",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (text) {
                            if (text.isEmpty)
                              return "Por Favor,insira um CPF/CNPJ!!";
                            else if (text.length > 14)
                              return "Por Favor,insira um CPF/CNPJ válido!!";
                            else if (text.length < 11)
                              return "Por Favor,insira um CPF/CNPJ válido!!";
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: TextFormField(
                          controller: loginBloc.senhaController,
                          decoration: InputDecoration(
                              hintText: "Senha",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (text) {
                            if (text.isEmpty)
                              return "Por Favor,insira a senha!!";
                            return null;
                          },
                          obscureText: true,
                        ),
                      ),
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
                                    borderRadius: BorderRadius.circular(10)),
                                minWidth: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 15,
                                child: RaisedButton(
                                  color: Colors.green,
                                  child: Text(
                                    "Entrar",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
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
                                        }else if(onValue == 1){
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
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 15,
                                margin: EdgeInsets.only(top: 0, bottom: 10),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
