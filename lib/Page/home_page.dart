import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:promotoraapp/Common/fab_bottom_app_bar.dart';
import 'package:promotoraapp/Page/contacts_page.dart';
import 'package:promotoraapp/Page/education_page.dart';
import 'package:promotoraapp/Page/goals_page.dart';
import 'package:promotoraapp/Page/services_page.dart';

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
    EducationsPage(),
    ServicesPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(context),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _onItemTapped,
        selectedColor: Theme.of(context).accentColor,
        color: Colors.black,
        items: [
          FABBottomAppBarItem(
            iconData: Icons.home_outlined,
            text: 'Mis metas',
          ),
          FABBottomAppBarItem(
            iconData: Icons.perm_contact_calendar_sharp,
            text: 'Contactos',
          ),
          FABBottomAppBarItem(
            iconData: Icons.cleaning_services,
            text: 'Servicios',
          ),
          FABBottomAppBarItem(
            iconData: Icons.cast_for_education_outlined,
            text: 'Educación',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _transmisionButton(context),
    );
  }

  Widget _topBar(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    double barHeight = currentOrientation == Orientation.portrait ? 100 : 50;

    return PreferredSize(
      preferredSize: Size(screenWidth, barHeight),
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('Educaión')],
          ),
        ),
      ),
    );
  }
}

Widget _transmisionButton(context) {
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 80),
    child: FloatingActionButton(
      elevation: 5.0,
      child: Icon(
        Icons.chat,
        color: Colors.white,
      ),
      onPressed: () {},
    ),
  );
}
