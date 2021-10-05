import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mi_promotora/common/bottom_chat.dart';
import 'package:mi_promotora/common/button_app_bar.dart';
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool routed = false;
  TabController _tabController;

  static const List<Widget> _widgetOptions = <Widget>[
    GoalsPage(),
    ContactsPage(),
    ServicesPage(),
    EducationPage(),
  ];

  void _onItemTapped(int index) {
    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    UsersProvider usersProvider = UsersProvider();
    usersProvider.updateUserDevice();

    _selectedIndex = 0;
    _tabController = TabController(vsync: this, length: _widgetOptions.length);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.indexIsChanging ||
            (_tabController.animation.value == _tabController.index)) {
          setState(() {
            _selectedIndex = _tabController.index;
          });
        }
      });
    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    if (!routed) {
      HomePageArguments args = ModalRoute.of(context).settings.arguments;
      setState(() {
        if (args != null) {
          _selectedIndex = args.selectedIndex;
          rebuildAllChildren(context);
          routed = true;
        }
      });
    }

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _widgetOptions,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        onTabSelected: _onItemTapped,
        selectedColor: MiPromotora().primaryDark,
        selectedIndex: _selectedIndex,
        items: [
          BottomAppBarItem(
            iconData: CupertinoIcons.house,
            text: 'Mis metas',
          ),
          BottomAppBarItem(
            iconData: CupertinoIcons.rectangle_stack_person_crop,
            text: 'Contactos',
          ),
          BottomAppBarItem(
            iconData: CupertinoIcons.heart,
            text: 'Servicios',
          ),
          BottomAppBarItem(
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
