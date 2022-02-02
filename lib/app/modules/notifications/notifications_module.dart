import 'package:app_digtec/app/modules/notifications/repository/notifications_repository.dart';
import 'package:app_digtec/app/modules/notifications/notifications_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/notifications/notifications_page.dart';

class NotificationsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => NotificationsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => NotificationsRepository()),
      ];

  @override
  Widget get view => NotificationsPage();

  static Inject get to => Inject<NotificationsModule>.of();
}
