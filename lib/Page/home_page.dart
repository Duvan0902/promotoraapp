import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:promotoraapp/Common/bottom_chat.dart';
import 'package:promotoraapp/Common/fab_button_app_bar.dart';
import 'package:promotoraapp/Page/contacts_page.dart';
import 'package:promotoraapp/Page/education_page.dart';
import 'package:promotoraapp/Page/goals_page.dart';
import 'package:promotoraapp/Page/services_page.dart';
import 'package:flutter/foundation.dart';
import 'package:promotoraapp/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    GoalsPage(),
    ContactsPage(),
    ServicesPage(),
    EducationsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _onItemTapped,
        selectedColor: PromotoraApp().primaryDark,
        items: [
          FABBottomAppBarItem(
            iconData: CupertinoIcons.house,
            text: 'Mis metas',
          ),
          FABBottomAppBarItem(
            iconData: CupertinoIcons.rectangle_stack_person_crop,
            text: 'Contactos',
          ),
          FABBottomAppBarItem(
            iconData: CupertinoIcons.heart,
            text: 'Servicios',
          ),
          FABBottomAppBarItem(
            iconData: CupertinoIcons.book,
            text: 'Educación',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _transmisionButton(context),
    );
  }

  Widget _transmisionButton(context) {
    return BottomChat();
  }
}
