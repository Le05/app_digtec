import 'package:app_digtec/app/modules/invoices/widgets/invoicesNotPaid/invoicesNotPaid_bloc.dart';
import 'package:app_digtec/app/modules/invoices/widgets/invoicesPaid/invoicesPaid_bloc.dart';
import 'package:app_digtec/app/modules/invoices/repository/invoices_repository.dart';
import 'package:app_digtec/app/modules/invoices/invoices_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/invoices/invoices_page.dart';

class InvoicesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => InvoicesNotPaidBloc()),
        Bloc((i) => InvoicesPaidBloc()),
        Bloc((i) => InvoicesBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => InvoicesRepository()),
      ];

  @override
  Widget get view => InvoicesPage();

  static Inject get to => Inject<InvoicesModule>.of();
}
