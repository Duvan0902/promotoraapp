import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/drawer.dart';
import 'package:promotoraapp/Page/contacts_list.dart';
import 'package:promotoraapp/Page/users_list.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/provider/contacts_provider.dart';
import 'package:promotoraapp/provider/users_provider.dart';

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
  SearchBar searchBar;
  Widget _currentWidget;
  TextEditingController myController = TextEditingController();
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: new Text('Buscar Contactos'),
      actions: [searchBar.getSearchAction(context)],
      backgroundColor: Colors.grey[900],
    );
  }

  _ContactsPageState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        controller: myController,
        buildDefaultAppBar: buildAppBar);

    print(myController);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tabs = [
      {"title": 'Empleados', "widget": jopList(context)},
      {"title": "Para tu gestión", "widget": managementList(context)}
    ];
    if (_currentWidget == null) {
      _currentWidget = jopList(context);
    }

    return Container(
      child: Scaffold(
        appBar: searchBar.build(context),
        drawer: DrawerPage(),
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
        decoration: BoxDecoration(
          color: selected ? PromotoraApp().primaryDark : PromotoraApp().grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        padding: EdgeInsets.fromLTRB(50, 15, 49, 15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget jopList(context) {
    final userProvider = UsersProvider();
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 20, 30),
      child: FutureBuilder(
        future: userProvider.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return UsersList(contacts: snapshot.data);
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
}

Widget managementList(context) {
  final contactProvider = ContactsProvider();
  return Container(
    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
    child: FutureBuilder(
      future: contactProvider.getContacts(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ContactsList(
            contacts: snapshot.data,
          );
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
