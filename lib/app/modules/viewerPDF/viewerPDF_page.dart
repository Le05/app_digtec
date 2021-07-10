import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/functionsGlobals/functionsGlobals.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';

class ViewerPDFPage extends StatefulWidget {
  final String title;
  const ViewerPDFPage({Key key, this.title = "Visualizar PDF"}) : super(key: key);

  @override
  _ViewerPDFPageState createState() => _ViewerPDFPageState();
}

class _ViewerPDFPageState extends State<ViewerPDFPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.share))
          ],
        ),
        body: FutureBuilder(
            future: FunctinsGlobals().abrirPDF(paramurlcontratoscm),
            builder: (context, snapshot) {
              if (snapshot.hasError) {}

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(child: PDFViewer(document: snapshot.data));
            }));
  }
}
