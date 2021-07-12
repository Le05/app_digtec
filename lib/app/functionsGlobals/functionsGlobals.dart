import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:path_provider/path_provider.dart';

String path;
class FunctinsGlobals {
  abrirPDF(String url) async {
    // baixar o pdf e salvar no local e abrir o mesmo
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path+"/arquivos/${DateTime.now().microsecondsSinceEpoch}.pdf";
    await dio.download(url, tempPath);
    path = tempPath;
    return await PDFDocument.fromFile(File(tempPath));
  }
}
