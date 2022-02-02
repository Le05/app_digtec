import 'package:app_digtec/app/modules/paymentPromise/repository/paymentPromisse_repository.dart';
import 'package:app_digtec/app/modules/paymentPromise/paymentPromise_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/paymentPromise/paymentPromise_page.dart';

class PaymentPromiseModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => PaymentPromiseBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => PaymentPromisseRepository()),
      ];

  @override
  Widget get view => PaymentPromisePage();

  static Inject get to => Inject<PaymentPromiseModule>.of();
}
