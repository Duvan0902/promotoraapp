import 'package:flutter/material.dart';
import 'package:promotoraapp/common/questions_answer.dart';
import 'package:promotoraapp/models/ranking_model.dart';
import 'package:promotoraapp/providers/ranking_provider.dart';

class TopTenPage extends StatelessWidget {
  const TopTenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[900],
          title: new Text(
            "Top 10",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 20),
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 75),
            child: Icon(Icons.ac_unit),
          ),
        ),
        body: Container(child: _ranking()),
      ),
    );
  }

  Widget _ranking() {
    final rankingProvider = RankingProvider();
    return Container(
      child: FutureBuilder(
        future: rankingProvider.getRanking(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _rankingList(snapshot.data);
          } else {
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _rankingList(List<RankingDataModel> ranking) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: ranking.length,
        itemBuilder: (context, index) {
          return ExpansionCard(
              questions: ranking[index].userCode, answer: ranking[index].name);
        },
      ),
    );
  }
}
