import 'package:flutter/material.dart';
import 'package:promotoraapp/common/drawer.dart';
import 'package:promotoraapp/pages/objective_Page.dart';
import 'package:promotoraapp/pages/self_management_page.dart';
import 'package:promotoraapp/main.dart';

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
      {"title": 'Tus metas', "widget": roomList(context)},
      {"title": "Autogestión", "widget": recordedList(context)}
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
          color: selected ? PromotoraApp().primaryDark : PromotoraApp().grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.w800),
        ),
        width: width,
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

  Widget recordedList(context) {
    return Container(
      child: SelfManagementPage(),
    );
  }
}
