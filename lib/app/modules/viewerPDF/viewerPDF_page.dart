import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/functionsGlobals/functionsGlobals.dart';
import 'package:franet/app/modules/viewerPDF/viewerPDF_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewerPDFPage extends StatefulWidget {
  final String title;
  final String url;
  const ViewerPDFPage({Key key, this.title = "Visualizar PDF", this.url})
      : super(key: key);

  @override
  _ViewerPDFPageState createState() => _ViewerPDFPageState();
}

ViewerPDFBloc viewerPDFBloc = ViewerPDFBloc();

class _ViewerPDFPageState extends State<ViewerPDFPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  viewerPDFBloc.compartilharPDF();
                },
                icon: Icon(Icons.share))
          ],
        ),
        body: FutureBuilder(
            future: FunctinsGlobals().abrirPDF(this.widget.url),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: this.widget.url,
                  
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(child: PDFViewer(document: snapshot.data));
            }));
  }
}
