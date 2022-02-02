import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationBloc extends BlocBase {
  Future openLink(String url) async {
    Box box = await getHiveInstance();
    url += "${box.get('contrato')}";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Future downloadImage() async {
    await dio.download(paramUseindiqueimg, "$tempDirPath/image-$paramUseindiqueimg.jpg");
    return File("$tempDirPath/image-$paramUseindiqueimg.jpg");
  }
  @override
  void dispose() {
    super.dispose();
  }
}