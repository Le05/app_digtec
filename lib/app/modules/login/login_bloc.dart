import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/models/ContractsModel.dart';
import 'package:franet/app/modules/chooseContracts/chooseContracts_module.dart';
import 'package:franet/app/modules/home/home_module.dart';
import 'package:franet/app/modules/login/login_module.dart';
import 'package:franet/app/modules/login/repository/login_repository.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  TextEditingController cpfCnpjController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  // classe que controla a regra de negocio da aplicação, no caso so da tela de login

  Box box;
  Future loginUser(BuildContext _) async {
    int retorno = 0;
    var repository = LoginModule.to.getDependency<LoginRepository>();

    await repository
        .login(cpfCnpjController.text, senhaController.text)
        .then((onValue) async {
      if (onValue["retorno"] == 1) {
        retorno = 1;
      } else if (onValue["retorno"] == 0) {
        saveContracts(senha: senhaController.text, choose: 1);
        saveContractsHive(onValue["contracts"]);
        setUltimoLogin();
        print("envia para tela de escolha de contratos");
        Navigator.pushReplacement(
            _,
            MaterialPageRoute(
                builder: (_) => ChooseContractsModule(onValue["contracts"])));
      } else if (onValue["retorno"] == 2) {
        setUltimoLogin();
        saveContracts(
            senha: senhaController.text,
            choose: 0,
            contracts: onValue["contracts"][0]);
        print("envia para a tela de dashboard, pois existe so um contrato");
        Navigator.pushReplacement(
            _, MaterialPageRoute(builder: (_) => HomeModule()));
      } else if (onValue["retorno"] == 3) {
        retorno = 3;
      }
    });
    if (retorno == 3) {
      return 3;
    } else if (retorno == 1) {
      return 1;
    }
  }

  final BehaviorSubject<bool> _login = BehaviorSubject<bool>();
  Sink<bool> get inputlogin => _login.sink;
  Stream get outputLogin => _login.stream;

  animacaoLogin(bool anime) {
    inputlogin.add(anime);
  }

  Future saveContracts(
      {Contracts contracts,
      @required String senha,
      @required int choose}) async {
    box = await getHiveInstance(); //initHive();
    if (choose == 0) {
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
    } else {
      box.put("senha", senha);
      print("salvou a senha dos varios contratos");
    }
  }

  Future saveContractsHive(List<Contracts> contract) async {
    contracts = contract;
    //box = await getHiveInstance();
    //box.put("contracts", contracts);
  }

  setUltimoLogin() {
    var checkLogin = box.get("salvarLogin");
    if (checkLogin != null && checkLogin == true) {
      box.put("ultimoLogin", cpfCnpjController.text);
    }
  }

  Future getImageLogin() async {
    box = await getHiveInstance();
    var file =
        await DefaultCacheManager().getFileFromCache(box.get("param_logotipo"));
    if (file == null) {
      await DefaultCacheManager().downloadFile(box.get("param_logotipo"));
      return await DefaultCacheManager().getFileFromCache(box.get("param_logotipo"));
    } else {
      return file;
    }
  }

  Future getpassword() async {
    box = await getHiveInstance();
    Map retorno = {
      "param_senha": box.get("param_senha"),
      "param_senhapadrao": box.get("param_senhapadrao")
    };
    return retorno;
  }

  Future getSaveLogin() async {
    box = await getHiveInstance();
    if (!box.containsKey("ultimoLogin") || !box.containsKey("salvarLogin")) {
      inputCheckSwitch.add(false);
      return cpfCnpjController;
    } else {
      inputCheckSwitch.add(box.get("salvarLogin"));
      cpfCnpjController.text = box.get("ultimoLogin");
      return cpfCnpjController;
    }
  }

  final BehaviorSubject<bool> _checkSwitch = BehaviorSubject<bool>();
  Sink<bool> get inputCheckSwitch => _checkSwitch.sink;
  Stream get outputCheckScwitch => _checkSwitch.stream;

  checkScwitch(bool check) async {
    box.put("salvarLogin", check);
    inputCheckSwitch.add(check);
  }

  verifyInternetAndBox() async {
     box = await getHiveInstance();
     var repository = LoginModule.to.getDependency<LoginRepository>();
     await repository.verificaInternet();
     return 0;
  }
  @override
  void dispose() {
    _login.close();
    _checkSwitch.close();
    super.dispose();
  }
}
