import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoicesNotPaidBloc extends BlocBase {
  launchPDF(String url) async {
    var box = await initHive();
    String ip = box.get("baseUrl");
    ip = ip.trim();
    List<String> splitada = ip.split("/");
    url = "${splitada[0]}//${splitada[2]}"+url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return 0;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
