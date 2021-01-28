import 'package:flutter/material.dart';
import 'package:mi_promotora/models/ranking_model.dart';
import 'package:mi_promotora/providers/ranking_provider.dart';
import 'package:recase/recase.dart';
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
          var rankingItem = ranking[index];
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
                title: rankingItem.insurance != null
                    ? Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          rankingItem.insurance,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black, fontSize: 16),
                        ),
                      )
                    : true,
                children: [
                  _rankingData(rankingItem.data),
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

  Widget _rankingData(List<RankingDataModel> seller) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: seller.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                  child: Text((index + 1).toString()),
                ),
                Flexible(child: Text(seller[index].name.titleCase)),
              ],
            ),
          );
        },
      ),
    );
  }
}
