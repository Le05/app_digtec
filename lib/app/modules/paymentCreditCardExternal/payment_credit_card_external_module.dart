import 'package:app_digtec/app/modules/paymentCreditCardExternal/payment_credit_card_external_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/paymentCreditCardExternal/payment_credit_card_external_page.dart';

class PaymentCreditCardExternalModule extends ModuleWidget {
  final String url;
  PaymentCreditCardExternalModule(this.url);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => PaymentCreditCardExternalBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => PaymentCreditCardExternalPage(url: this.url,);

  static Inject get to => Inject<PaymentCreditCardExternalModule>.of();
}
