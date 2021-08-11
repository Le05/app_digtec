import 'package:flutter/material.dart';
import 'package:franet/app/models/ContractsModel.dart';
import 'package:franet/app/modules/chooseContracts/chooseContracts_bloc.dart';
import 'package:franet/app/modules/home/home_module.dart';
import 'package:franet/app/modules/login/login_module.dart';
import 'package:intl/intl.dart';

class ChooseContractsPage extends StatefulWidget {
  final String title;
  final List<Contracts> contracts;
  const ChooseContractsPage(
      {Key key, this.title = "Escolha de Contratos", @required this.contracts})
      : super(key: key);

  @override
  _ChooseContractsPageState createState() => _ChooseContractsPageState();
}

ChooseContractsBloc chooseContractsBloc = ChooseContractsBloc();
var currencyFormatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

class _ChooseContractsPageState extends State<ChooseContractsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginModule()));
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                  //margin: EdgeInsets.only(
                  // top: 5),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: widget.contracts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            ExpansionTile(
                              title: InkWell(
                                child: Text(
                                    "Contrato: ${widget.contracts[index].contrato} ${widget.contracts[index].razaoSocial}"),
                                onTap: () async {
                                  await ChooseContractsBloc()
                                      .saveContractsChoose(
                                          widget.contracts[index]);
                                  await ChooseContractsBloc()
                                      .enviarDadosDispositivo(
                                          widget.contracts[index]);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomeModule()));
                                },
                              ),
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Contrato: ${widget.contracts[index].contrato}"),
                                    Text(
                                        "CPF/CNPJ: ${widget.contracts[index].cpfCnpj}"),
                                    Text(
                                        "Status: ${widget.contracts[index].status}"),
                                    Text(
                                        "Plano de Internet: ${widget.contracts[index].planoInternet}"),
                                        
                                    Text(widget.contracts[index].planoInternetValor == 0 || widget.contracts[index].planoInternetValor == null ? "" :
                                        "Valor do Plano: ${currencyFormatter.format(widget.contracts[index].planoInternetValor)}"),
                                    Text(
                                        "Vencimento: ${widget.contracts[index].vencimento}")
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ))
            ],
          ),
        ));
  }
}
