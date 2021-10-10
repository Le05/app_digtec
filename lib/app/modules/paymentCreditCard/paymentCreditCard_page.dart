import 'dart:convert';

import 'package:awesome_card/awesome_card.dart' as awesomCard;
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart'
    as flutterCreditCard;
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

String numeroCartao = "";
String dataExpiracao = "XX/XXXX";
String cvv = "";
bool checkBox = false;
bool backCvv = false;
String nomeCartao = "NOME";
bool estadoBotao = false;

final _formKey = GlobalKey<FormState>();

class _PaymentCreditCardPageState extends State<PaymentCreditCardPage> {
  @override
  void initState() {
    super.initState();
    paymentCreditCardBloc.cartaoOutro = false;
  }

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
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: awesomCard.CreditCard(
                              cardNumber: snapshot.data[0]["numero_final"],
                              cardExpiry: "**/**",
                              cardHolderName: nomeCartao,
                              cvv: cvv,
                              //bankName: "Axis Bank",
                              cardType: awesomCard.CardType
                                  .masterCard, // Optional if you want to override Card Type
                              showBackSide: false,
                              frontBackground: awesomCard.CardBackgrounds.black,
                              backBackground: awesomCard.CardBackgrounds.white,
                              showShadow: true,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: AnimatedCrossFade(
                                    crossFadeState: estadoBotao
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: Duration(seconds: 1),
                                    firstChild: ButtonTheme(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Theme.of(context)
                                                        .primaryColor)),
                                        child: Text(
                                          "Pagar utilizando este Cartão",
                                          style: TextStyle(
                                            color: corfontebuttonhome == null
                                                ? Colors.black
                                                : corfontebuttonhome,
                                          ),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            estadoBotao = true;
                                          });
                                          try {
                                            await paymentCreditCardBloc
                                                .pagarComCartaoSalvo(
                                                    fatura,
                                                    snapshot.data[index]["id"],
                                                    emails[0]);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Fatura paga"),
                                            ));
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Ocorreu um erro ao pagar"),
                                            ));
                                          }
                                          setState(() {
                                            estadoBotao = false;
                                          });
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
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: ButtonTheme(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    child: ElevatedButton(
                                        child: Text(
                                            "Pagar utilizando outro cartão",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          setState(() {
                                            paymentCreditCardBloc.cartaoOutro =
                                                true;
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return ListView(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: flutterCreditCard.CreditCardWidget(
                          onCreditCardWidgetChange: (value){},
                          cardBgColor: Colors.indigo[800],
                          cardNumber: numeroCartao,
                          expiryDate: dataExpiracao,
                          cardHolderName: nomeCartao,
                          cvvCode: cvv,
                          showBackView: backCvv,
                          height: 175,
                          textStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold),
                          width: MediaQuery.of(context).size.width,
                          animationDuration: Duration(milliseconds: 1000),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          maxLength: 19,
                          controller:
                              paymentCreditCardBloc.numeroCartaoController,
                          keyboardType: TextInputType.numberWithOptions(),
                          onChanged: (text) {
                            setState(() {
                              backCvv = false;
                              numeroCartao = text;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Numero do cartão",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (text) {
                            if (text.isEmpty)
                              return "Por favor, insira um numero";
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          //maxLength: 5,
                          controller:
                              paymentCreditCardBloc.dataExpiracaoController,
                          keyboardType: TextInputType.numberWithOptions(),
                          onChanged: (text) {
                            if (text.length <= 7)
                              setState(() {
                                backCvv = false;
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
                              return "Por favor, insira uma data expiração";
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: paymentCreditCardBloc.cvvController,
                          keyboardType: TextInputType.numberWithOptions(),
                          onChanged: (text) {
                            if (text.length <= 3)
                              setState(() {
                                backCvv = true;
                                cvv = text;
                              });
                          },
                          decoration: InputDecoration(
                              hintText: "CVV",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (text) {
                            if (text.isEmpty) return "Por favor, insira o CVV";

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      emails == null
                          ? Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 15),
                              child: TextFormField(
                                controller:
                                    paymentCreditCardBloc.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: "Digite o email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)))),
                                validator: (text) {
                                  if (text.isEmpty)
                                    return "Por favor, insira um email";

                                  return null;
                                },
                              ),
                            )
                          : Container(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller:
                              paymentCreditCardBloc.nomeCartaoController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          onChanged: (text) {
                            setState(() {
                              backCvv = false;
                              nomeCartao = text.toUpperCase();
                              if (base64.encode(utf8.encode(key + token)) !=
                                  cripto) token = cripto;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Digite o nome do cartão",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (text) {
                            if (text.isEmpty)
                              return "Por favor, insira o nome cart!ao";

                            return null;
                          },
                        ),
                      ),
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
                                "Salvar Cartão (Pagamentos Futuros)",
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
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    "Pagar com Cartão",
                                    style: TextStyle(
                                        color: corfontebuttonhome == null
                                            ? Colors.black
                                            : corfontebuttonhome,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      paymentCreditCardBloc
                                          .animacaoCadastro(true);
                                      try {
                                        await paymentCreditCardBloc
                                            .pagarComCartao(
                                                fatura,
                                                numeroCartao,
                                                nomeCartao,
                                                dataExpiracao,
                                                cvv,
                                                emails[0],
                                                checkBox);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("Fatura paga com sucesso!"),
                                        ));
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Ocorreu um erro"),
                                        ));
                                      }
                                      paymentCreditCardBloc
                                          .animacaoCadastro(false);
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
                    ],
                  )
                ]);
              }),
        ));
  }
}
