import 'package:flutter/material.dart';

class IconsAcessRapidWidget extends StatelessWidget {
  final IconData icone;
  final String urlLauncher;
  final int exibe;

  const IconsAcessRapidWidget({Key key, this.icone, this.urlLauncher,this.exibe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(exibe == 1){
      return ElevatedButton(
        onPressed: () {},
        child: Icon(icone),
        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
        ),
      );
    } else {
      return Container();
    }
      
      
  }
}
