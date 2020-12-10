import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/raised_Button.dart';
import 'package:promotoraapp/main.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  void initState() {
    super.initState();
  }

  int _selectedTab = 0;

  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tabs = [
      {"title": 'Empleados', "widget": roomList(context)},
      {"title": "Para tu gestion", "widget": recordedList(context)}
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
        decoration: BoxDecoration(
          color: selected ? PromotoraApp().primaryDark : PromotoraApp().grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        padding: EdgeInsets.fromLTRB(50, 20, 49, 20),
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
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          BottomList(
            title: 'contacto',
            route: 'contact',
            icon: IconButton(
              icon: Icon(Icons.call_outlined),
              iconSize: 36,
              onPressed: () {},
            ),
          ),
          SizedBox(height: 20),
          BottomList(
            title: 'contacto',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.call_outlined),
              iconSize: 36,
              onPressed: () {},
            ),
          ),
          SizedBox(height: 20),
          BottomList(
            title: 'contacto',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.call_outlined),
              iconSize: 36,
              onPressed: () {},
            ),
          ),
          SizedBox(height: 20),
          BottomList(
            title: 'contacto',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.call_outlined),
              iconSize: 36,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget recordedList(context) {
    return Text('7777');
  }
}
