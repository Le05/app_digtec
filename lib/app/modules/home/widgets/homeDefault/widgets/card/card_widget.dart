import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String paramIconeCustom;
  final String paramUrlIcone;
  final String paramNomeIconeDefault;
  final String paramNomeLabel;
  final bool paramNomeGrande;

  const CardWidget(this.paramIconeCustom, this.paramUrlIcone,
      this.paramNomeIconeDefault, this.paramNomeLabel, this.paramNomeGrande);
  @override
  Widget build(BuildContext context) {
    print(paramNomeLabel.split("<br>").length);
    return Card(
      elevation: 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          paramIconeCustom == "1" && paramUrlIcone != ""
              ? CachedNetworkImage(
                  imageUrl: paramUrlIcone,
                  width: MediaQuery.of(context).size.width / 3.1,
                  height: MediaQuery.of(context).size.height / 10,
                )
              : Image.asset(
                  paramNomeIconeDefault,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 10,
                ),
          SizedBox(
            height: 5,
          ),
          paramNomeGrande
              ? Container(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(paramNomeLabel.split("<br>")[0]),
                      Text(paramNomeLabel.split("<br>")[1]),
                      Text(paramNomeLabel.split("<br>").length > 2 ? paramNomeLabel.split("<br>")[2] : "")
                    ],
                  ))
              : Text(paramNomeLabel),
        ],
      ),
    );
  }
}
