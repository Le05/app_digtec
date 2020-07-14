import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:franet/app/modules/paymentCreditCard/paymentCreditCard_module.dart';
import 'package:franet/app/modules/paymentCreditCard/repository/paymentCreditCard_repository.dart';
import 'package:rxdart/rxdart.dart';

class PaymentCreditCardBloc extends BlocBase {
  TextEditingController numeroCartaoController =
       MaskedTextController(mask: '0000 0000 0000 0000');
      TextEditingController dataExpiracaoController =
       MaskedTextController(mask: '00/0000');
      TextEditingController cvvController =
       MaskedTextController(mask: '000');
    TextEditingController emailController = TextEditingController();
    TextEditingController nomeCartaoController = TextEditingController();
    
    bool cartaoOutro;

   var repository =
        PaymentCreditCardModule.to.getDependency<PaymentCreditCardRepository>();

  Future buscarCartoesSalvos() async {
    if(cartaoOutro == false){
      return repository.buscarCartoes();
    }else{
      return [];
    }
    
  }

  Future pagarComCartao(int fatura,String numero,String nome,String expira,String cvv,String email,bool salvarCartao) async{
    return repository.pagarComCartao(fatura, numero, nome,expira, cvv, email, salvarCartao);
  }

  Future pagarComCartaoSalvo(int fatura,int cartaoId,String email)async{
    return repository.pagarComCartaoSalvo(fatura, cartaoId,email);
  }

    final BehaviorSubject<bool> _cadastrarCartao = BehaviorSubject<bool>();
  Sink<bool> get inputCadastro => _cadastrarCartao.sink;
  Stream get outputCadastro => _cadastrarCartao.stream;

  animacaoCadastro(bool anime) {
    inputCadastro.add(anime);
  }
  @override
  void dispose() {
    _cadastrarCartao.close();
    super.dispose();
  }
}
