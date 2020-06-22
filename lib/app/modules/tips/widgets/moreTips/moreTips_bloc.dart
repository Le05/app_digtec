import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreTipsBloc extends BlocBase {
  abrirUrl(String url) async {
    await launch(url);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
