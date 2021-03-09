import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mi_promotora/common/bottom_chat.dart';
import 'package:mi_promotora/common/fab_button_app_bar.dart';
import 'package:mi_promotora/pages/contacts_page.dart';
import 'package:mi_promotora/pages/education_page.dart';
import 'package:mi_promotora/pages/goals_page.dart';
import 'package:mi_promotora/pages/services_page.dart';
import 'package:flutter/foundation.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/providers/users_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool routed = false;

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
  void initState() {
    super.initState();
    UsersProvider usersProvider = UsersProvider();
    usersProvider.updateUserDevice();
  }

  @override
  Widget build(BuildContext context) {
    if (!routed) {
      HomePageArguments args = ModalRoute.of(context).settings.arguments;
      setState(() {
        if (args != null) {
          _selectedIndex = args.selectedIndex;
          routed = true;
        }
      });
    }

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _onItemTapped,
        selectedColor: MiPromotora().primaryDark,
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
      floatingActionButton: BottomChat(),
    );
  }
}

class HomePageArguments {
  final int selectedIndex;
  final Object widgetArguments;

  HomePageArguments(this.selectedIndex, this.widgetArguments);
}
