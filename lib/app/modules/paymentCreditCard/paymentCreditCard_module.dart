import 'package:franet/app/modules/paymentCreditCard/repository/paymentCreditCard_repository.dart';
import 'package:franet/app/modules/paymentCreditCard/paymentCreditCard_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/paymentCreditCard/paymentCreditCard_page.dart';

class PaymentCreditCardModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => PaymentCreditCardBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => PaymentCreditCardRepository()),
      ];

  @override
  Widget get view => PaymentCreditCardPage();

  static Inject get to => Inject<PaymentCreditCardModule>.of();
}
