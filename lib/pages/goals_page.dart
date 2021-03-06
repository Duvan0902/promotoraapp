import 'package:flutter/material.dart';
import 'package:mi_promotora/common/settings_menu.dart';
import 'package:mi_promotora/common/drawer.dart';
import 'package:mi_promotora/models/goals_model.dart';
import 'package:mi_promotora/pages/goals_information_page.dart';
import 'package:mi_promotora/pages/management_page.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/providers/goals_provider.dart';

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
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[900],
          title: Text("Mis metas",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: Colors.white, fontSize: 20)),
          actions: [
            PopupButton(),
          ],
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
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
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey[900],
      child: FutureBuilder(
        future: goalsProvider.getGoal(),
        builder: (BuildContext context, AsyncSnapshot<GoalsModel> snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              return GoalInformationPage(
                goals: snapshot.data,
              );
            } else {
              return Center(
                child: Container(
                  width: size.width * 0.6,
                  child: Text(
                    "No se ha podido obtener la información asociada al usuario",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                ),
              );
            }
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
}
