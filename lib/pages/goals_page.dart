import 'package:flutter/material.dart';
import 'package:promotoraapp/common/drawer.dart';
import 'package:promotoraapp/models/goals_model.dart';
import 'package:promotoraapp/pages/goals_information_page.dart';
import 'package:promotoraapp/pages/objective_Page.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/providers/goals_provider.dart';

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
      _currentWidget = roomList(context);
    }

    return Container(
      child: Scaffold(
        appBar: _topBar(context),
        drawer: CustomDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(50, 15, 61, 15),
        decoration: BoxDecoration(
          color: selected ? PromotoraApp().primaryDark : PromotoraApp().grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _topBar(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    double barHeight = currentOrientation == Orientation.portrait ? 60 : 50;
    return PreferredSize(
      preferredSize: Size(screenWidth, barHeight),
      child: Container(
        child: AppBar(
          backgroundColor: Colors.grey[900],
          title: new Text("Mis metas"),
        ),
      ),
    );
  }

  Widget roomList(context) {
    return Container(
      child: MyObjetivePage(),
    );
  }

  Widget goalInformationList(context) {
    final servicesProvider = GoalsProvider();
    return Container(
      color: Colors.grey[900],
      child: FutureBuilder(
        future: servicesProvider.getGoals(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _contactsList(snapshot.data);
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

  Widget _contactsList(List<GoalsModel> contacts) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return GoaldInformationPage(
            goasl: contacts[index],
          );
        },
      ),
    );
  }
}
