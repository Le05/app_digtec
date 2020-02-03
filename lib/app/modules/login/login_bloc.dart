import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/models/ContractsModel.dart';
import 'package:franet/app/modules/chooseContracts/chooseContracts_module.dart';
import 'package:franet/app/modules/home/home_module.dart';
import 'package:franet/app/modules/login/login_module.dart';
import 'package:franet/app/modules/login/repository/login_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  TextEditingController cpfCnpjController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  // classe que controla a regra de negocio da aplicação, no caso so da tela de login

  Future loginUser(BuildContext _) async {
    int retorno = 0;
    var repository = LoginModule.to.getDependency<LoginRepository>();

    await repository.login(cpfCnpjController.text, senhaController.text).then((onValue) async {
      if(onValue["retorno"] == 1){
        retorno = 1;
      }else if(onValue["retorno"] == 0){
        saveContracts(senha: senhaController.text, choose: 1);
        print("envia para tela de escolha de contratos");
        Navigator.pushReplacement(_, MaterialPageRoute(builder: (_)=> ChooseContractsModule(onValue["contracts"])));
      }else if(onValue["retorno"] == 2){
        saveContracts(senha: senhaController.text,choose:0,contracts: onValue["contracts"][0]);
        print("envia para a tela de dashboard, pois existe so um contrato");
        Navigator.pushReplacement(_, MaterialPageRoute(builder: (_)=> HomeModule()));
      }else if(onValue["retorno"] == 3){
        retorno = 3;
      }
    });
    if(retorno == 3){
      return 3;
    }else if(retorno == 1){
      return 1;
    }
  }

  final BehaviorSubject<bool> _login = BehaviorSubject<bool>();
  Sink<bool> get inputLogin => _login.sink;
  Stream get outputLogin => _login.stream;

  animacaoLogin(bool anime) {
    inputLogin.add(anime);
  }

  Future saveContracts({Contracts contracts,@required String senha,@required int choose}) async {
    var box = await initHive();
    if(choose == 0){
    box.put("cpfCnpj", contracts.cpfCnpj);
    box.put("senha", senha);
    box.put("contrato", contracts.contrato);
    box.put("planoInternet", contracts.planoInternet);
    box.put("planoInternetId", contracts.planoInternetId);
    box.put("razaoSocial", contracts.razaoSocial);
    box.put("status", contracts.status);
    box.put("vencimento", contracts.vencimento);
    box.put("planoInternetValor", contracts.planoInternetValor);
    print("salvou tudo os dados do contrato unico");
    }else{
      box.put("senha", senha);
    print("salvou a senha dos varios contratos");
    }
    
  }
  @override
  void dispose() {
    _login.close();
    super.dispose();
  }
}
