import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:promotoraapp/Common/bottom_chat.dart';
import 'package:promotoraapp/Common/fab_button_app_bar.dart';
import 'package:promotoraapp/Common/raised_Button.dart';
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
      appBar: _topBar(context),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(80.0),
        ),
        child: Drawer(
          child: Container(
            color: PromotoraApp().primaryDark,
            child: ListView(
              padding: const EdgeInsets.all(21),
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  'Tu sesión en Promotora',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black, fontSize: 33),
                ),
                SizedBox(height: 40),
                BottomList(
                  title: 'Mis metas',
                  icon: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: 28,
                    onPressed: () {},
                  ),
                  route: 'sale',
                ),
                SizedBox(height: 18),
                BottomList(
                  title: 'Preguntas Frecuentes',
                  icon: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: 28,
                    onPressed: () {},
                  ),
                  route: 'questions',
                ),
                SizedBox(height: 18),
                BottomList(
                  title: 'Documentos para tu gestion',
                  icon: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: 28,
                    onPressed: () {},
                  ),
                  route: 'sale',
                ),
                SizedBox(height: 18),
                BottomList(
                  title: 'Chat',
                  icon: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: 28,
                    onPressed: () {},
                  ),
                  route: 'sale',
                ),
                SizedBox(height: 200),
                BottomList(
                  title: 'Cerrar sesión',
                  icon: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: 28,
                    onPressed: () {},
                  ),
                  route: 'sale',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _onItemTapped,
        selectedColor: PromotoraApp().primaryDark,
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
    double barHeight = currentOrientation == Orientation.portrait ? 60 : 50;
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
  return BottomChat();
}
