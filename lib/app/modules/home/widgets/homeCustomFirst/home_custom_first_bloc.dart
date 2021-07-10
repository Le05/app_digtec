import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCustomFirstBloc extends BlocBase {
  abrirUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  abrirNovaTela(context, Widget novaTela) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => novaTela));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
