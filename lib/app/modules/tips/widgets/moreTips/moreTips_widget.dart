import 'package:flutter/material.dart';
import 'package:flutter_native_html_view/flutter_native_html_view.dart';
import 'package:app_digtec/app/modules/tips/widgets/moreTips/moreTips_bloc.dart';

class MoreTipsWidget extends StatelessWidget {
  final tip;

  const MoreTipsWidget(Key key, this.tip) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tip["dicas_title"]),
        ),
        body: FlutterNativeHtmlView(
          htmlData: tip["dicas_desc"],
          onLinkTap: (String url) async {
            await MoreTipsBloc().abrirUrl(url);
          },
        ) /*SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  tip["dicas_title"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Html(data: tip["dicas_desc"]),
                )
          ],
        ),
      ),*/
        );
  }
}
