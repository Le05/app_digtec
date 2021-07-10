import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class FunctinsGlobals {
  abrirPDF(String url) async {
    return await PDFDocument.fromURL(url);
  }
}
