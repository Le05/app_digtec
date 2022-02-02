import 'package:flutter/material.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';
import 'package:app_digtec/app/modules/home/widgets/recommendation/recommendation_bloc.dart';

RecommendationBloc recommendationBloc = RecommendationBloc();
class RecommendationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top:0, left: 0, right: 0),
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container();
            }

            if(snapshot.hasError){
              return Center(child: Text("Ocorreu um erro"),);
            }

            return Image.file(snapshot.data);
        }),
        // child: Image.network(paramUseindiqueimg),
      ),
      onTap: () async {
        await recommendationBloc.openLink(paramUseindiqueurl);
      },
    );
  }
}
