import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/objective.dart';
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

    return Column(
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

  Widget roomList(context) {
    return Container(
      child: MyObjetive(),
    );
  }

  Widget recordedList(context) {
    return Text('7777');
  }
}
