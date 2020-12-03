import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:promotoraapp/Common/fab_bottom_app_bar.dart';
import 'package:promotoraapp/Common/raisedButton.dart';
import 'package:promotoraapp/Page/contacts_page.dart';
import 'package:promotoraapp/Page/education_page.dart';
import 'package:promotoraapp/Page/goals_page.dart';
import 'package:promotoraapp/Page/services_page.dart';
import 'package:flutter/foundation.dart';

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
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(100.0),
        ),
        child: Drawer(
          child: Container(
            color: Color.fromRGBO(0, 186, 193, 3),
            child: new ListView(
              padding: const EdgeInsets.all(21),
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Tu sesión      en Promotora',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 33),
                ),
                SizedBox(height: 40),
                BottomList(
                  title: 'Mis metas',
                  title2: '',
                ),
                SizedBox(height: 20),
                BottomList(
                  title: 'Preguntas',
                  title2: '',
                ),
                SizedBox(height: 20),
                BottomList(
                  title: 'chat',
                  title2: '',
                ),
                SizedBox(height: 181),
                BottomList(
                  title: '',
                  title2: 'Cerrar sesión',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _onItemTapped,
        selectedColor: Theme.of(context).accentColor,
        color: Colors.grey[900],
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
        child: AppBar(
          backgroundColor: Colors.grey[900],
          title: new Text("Educación"),
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
