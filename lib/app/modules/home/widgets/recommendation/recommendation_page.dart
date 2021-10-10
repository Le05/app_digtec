import 'package:flutter/material.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:franet/app/modules/home/widgets/recommendation/recommendation_bloc.dart';

RecommendationBloc recommendationBloc = RecommendationBloc();
class RecommendationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top:0, left: 0, right: 0),
        width: MediaQuery.of(context).size.width,
        child: Image.network(paramUseindiqueimg),
      ),
      onTap: () async {
        await recommendationBloc.openLink(paramUseindiqueurl);
      },
    );
  }
}
