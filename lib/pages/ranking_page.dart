import 'package:flutter/material.dart';
import 'package:MiPromotora/models/ranking_model.dart';
import 'package:MiPromotora/providers/ranking_provider.dart';

import '../main.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

List<String> interests = [];

class _RankingPageState extends State<RankingPage> {
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
        builder:
            (BuildContext context, AsyncSnapshot<List<RankingModel>> snapshot) {
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

  Widget _rankingList(List<RankingModel> ranking) {
    bool _expanded = false;
    Color iconColor = MiPromotora().primaryDark;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: ranking.length,
        itemBuilder: (context, index) {
          var top = ranking[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ExpansionTile(
                trailing: _expanded
                    ? Icon(
                        Icons.remove_circle_outline,
                        color: iconColor,
                      )
                    : Icon(
                        Icons.add_circle_outline,
                        color: iconColor,
                      ),
                title: top.insurance != null
                    ? Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          top.insurance,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black, fontSize: 16),
                        ),
                      )
                    : true,
                children: [
                  _subCategory(top.data),
                  SizedBox(height: 5),
                ],
                onExpansionChanged: (changed) {
                  setState(() {
                    _expanded = changed;
                  });
                },
                initiallyExpanded: _expanded,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _subCategory(List<RankingDataModel> top) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      child: ListView.builder(
        itemCount: top.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(top[index].name)],
          );
        },
      ),
    );
  }
}
