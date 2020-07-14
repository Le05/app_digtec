import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/paymentCreditCard/paymentCreditCard_bloc.dart';

class PaymentCreditCardPage extends StatefulWidget {
  final String title;
  const PaymentCreditCardPage({Key key, this.title = "Pagamento com Cartão"})
      : super(key: key);

  @override
  _PaymentCreditCardPageState createState() => _PaymentCreditCardPageState();
}

PaymentCreditCardBloc paymentCreditCardBloc = PaymentCreditCardBloc();

String numeroCartao;
String dataExpiracao;
String cvv;
bool checkBox = false;
final _formKey = GlobalKey<FormState>();

class _PaymentCreditCardPageState extends State<PaymentCreditCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: FutureBuilder(
              future: paymentCreditCardBloc.buscarCartoesSalvos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    ),
                  );
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
                if (snapshot.data.length > 0) {
                  return ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: CreditCard(
                          cardNumber: snapshot.data[0]["numero_final"],
                          cardExpiry: "**/**",
                          //cardHolderName: "Card Holder",
                          //cvv: "456",
                          //bankName: "Axis Bank",
                          cardType: CardType
                              .masterCard, // Optional if you want to override Card Type
                          showBackSide: false,
                          frontBackground: CardBackgrounds.black,
                          backBackground: CardBackgrounds.white,
                          showShadow: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              height: MediaQuery.of(context).size.height / 20,
                              child: RaisedButton(
                                  child: Text("Pagar utilizando este cartão",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {}),
                            ),
                            ButtonTheme(
                              height: MediaQuery.of(context).size.height / 20,
                              child: RaisedButton(
                                  child: Text("Pagar utilizando outro cartão",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {}),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: CreditCard(
                      cardNumber: numeroCartao,
                      cardExpiry: dataExpiracao,
                      cardHolderName: "",
                      cvv: cvv,
                      bankName: "",
                      cardType: CardType
                          .masterCard, // Optional if you want to override Card Type
                      showBackSide: false,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.white,
                      showShadow: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      maxLength: 19,
                      controller: paymentCreditCardBloc.numeroCartaoController,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (text) {
                        setState(() {
                          numeroCartao = text;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Numero do cartão",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      validator: (text) {
                        if (text.isEmpty) return "Por Favor,insira um numero";
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      maxLength: 5,
                      controller: paymentCreditCardBloc.dataExpiracaoController,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (text) {
                        setState(() {
                          dataExpiracao = text;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Data Expiração",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      validator: (text) {
                        if (text.isEmpty)
                          return "Por Favor,insira uma Data Expiração";
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: paymentCreditCardBloc.cvvController,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (text) {
                        setState(() {
                          cvv = text;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "CVV",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      validator: (text) {
                        if (text.isEmpty) return "Por Favor,insira o cvv";

                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  emails == null
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: paymentCreditCardBloc.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Digite o email",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)))),
                            validator: (text) {
                              if (text.isEmpty) return "Por Favor,insira um email";

                              return null;
                            },
                          ),
                        )
                      : Container(),
                  Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 5),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              value: checkBox,
                              onChanged: (value) {
                                setState(() {
                                  checkBox = value;
                                });
                              }),
                          Text(
                            "Gravar dados para proximas faturas",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: paymentCreditCardBloc.outputCadastro,
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
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Cadastrar e Pagar com Cartão",
                                style: TextStyle(
                                    color: corfontebuttonhome == null
                                        ? Colors.black
                                        : corfontebuttonhome,
                                    fontSize: 16),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  paymentCreditCardBloc.animacaoCadastro(true);
                                  //paymentCreditCardBloc.cadastrarCartao();
                                  paymentCreditCardBloc.animacaoCadastro(false);
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
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ]);
              }),
        ));
  }
}
