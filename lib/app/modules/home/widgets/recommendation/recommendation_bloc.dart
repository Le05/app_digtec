import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationBloc extends BlocBase {
  Future openLink(String url) async {
    Box box = await getHiveInstance();
    url += "usp=pp_url&entry.484538181=${box.get('contrato')}";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
  @override
  void dispose() {
    super.dispose();
  }
}