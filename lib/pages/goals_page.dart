import 'package:flutter/material.dart';
import 'package:MiPromotora/common/drawer.dart';
import 'package:MiPromotora/models/goals_model.dart';
import 'package:MiPromotora/pages/goals_information_page.dart';
import 'package:MiPromotora/pages/management_page.dart';
import 'package:MiPromotora/main.dart';
import 'package:MiPromotora/providers/goals_provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key key}) : super(key: key);
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedTab = 0;
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tabs = [
      {"title": 'Tus metas', "widget": goalInformationList(context)},
      {"title": "Autogestión", "widget": roomList(context)}
    ];
    if (_currentWidget == null) {
      _currentWidget = goalInformationList(context);
    }

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: new Text(
            "Mis metas",
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: Colors.white, fontSize: 20),
          ),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: tabs.map((tab) {
                  int currentIndex = tabs.indexOf(tab);
                  bool selected = currentIndex == _selectedTab;

                  Function onTabFunction = () {
                    setState(() {
                      _selectedTab = currentIndex;
                      _currentWidget = tab['widget'];
                    });
                  };

                  return _tab(tab["title"], onTabFunction, selected);
                }).toList(),
              ),
            ),
            Expanded(
              child: _currentWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String title, Function onTap, selected) {
    double borderRadius = 10;
    double width = (MediaQuery.of(context).size.width / 2) - 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: selected ? MiPromotora().grey : MiPromotora().primaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: selected ? Colors.white : Colors.white,
              fontWeight: FontWeight.w800),
        ),
        width: width,
      ),
    );
  }

  Widget roomList(context) {
    return Container(
      child: ManagementPage(),
    );
  }

  Widget goalInformationList(context) {
    final goalsProvider = GoalsProvider();
    return Container(
      color: Colors.grey[900],
      child: FutureBuilder(
        future: goalsProvider.getGoal(),
        builder: (BuildContext context, AsyncSnapshot<GoalsModel> snapshot) {
          if (snapshot.hasData) {
            return _goalsList(snapshot.data);
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

  Widget _goalsList(GoalsModel goal) {
    return GoaldInformationPage(
      goasl: goal,
    );
  }
}
