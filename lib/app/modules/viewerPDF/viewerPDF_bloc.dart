import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:app_digtec/app/functionsGlobals/functionsGlobals.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_extend/share_extend.dart';

class ViewerPDFBloc extends BlocBase {
  compartilharPDF() async {
    if(path != "")
      ShareExtend.share(path, "file");
  }

  final BehaviorSubject<dynamic> _carregarPDF = BehaviorSubject<dynamic>();
  Sink<dynamic> get inputCarregamento => _carregarPDF.sink;
  Stream get outputCarregamento => _carregarPDF.stream;

  @override
  void dispose() {
    _carregarPDF.close();
    super.dispose();
  }
}
