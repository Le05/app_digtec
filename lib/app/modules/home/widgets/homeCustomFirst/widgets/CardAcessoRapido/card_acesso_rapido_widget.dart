import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardAcessoRapidoWidget extends StatelessWidget {
  final String label;
  final String urlIcone;
  final String iconeCustom;
  final Function funcao;

  const CardAcessoRapidoWidget(
      {Key key, this.label, this.urlIcone, this.iconeCustom,this.funcao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        // color: Colors.grey,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconeCustom == "1"
                  ? CachedNetworkImage(
                      imageUrl: urlIcone,
                      width: MediaQuery.of(context).size.width / 3.1,
                      height: MediaQuery.of(context).size.height / 10,
                    )
                  : Image.asset(
                      urlIcone,
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 10,
                    ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Row(
                  children: [
                    Expanded(child: Text(label)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: funcao,
    );
  }
}
