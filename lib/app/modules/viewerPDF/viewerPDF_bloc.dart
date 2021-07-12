import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:franet/app/functionsGlobals/functionsGlobals.dart';
import 'package:share_extend/share_extend.dart';

class ViewerPDFBloc extends BlocBase {
  compartilharPDF() async {
    if(path != "")
      ShareExtend.share(path, "file");
  }

  @override
  void dispose() {
    super.dispose();
  }
}
