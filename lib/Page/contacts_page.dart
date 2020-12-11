import 'package:flutter/material.dart';

import 'package:promotoraapp/Common/contacts_list.dart';
import 'package:promotoraapp/Common/contacts_management.dart';

import 'package:promotoraapp/Model/users_model.dart';
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
    UsersProvider usersProvider = UsersProvider();
    return FutureBuilder(
      future: usersProvider.getUsers(),
      builder: (BuildContext context, AsyncSnapshot<UsersModel> snapshot) {
        if (snapshot.hasData) {
          UsersModel users = snapshot.data;
          print(users);
          List<UsersModel> role;

          return _sections(context, role);
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Widget recordedList(context) {
  final contactProvider = ContactsProvider();
  return Container(
    child: FutureBuilder(
      future: contactProvider.getContacts(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ContactsList(contacts: snapshot.data);
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

Widget _sections(context, List<UsersModel> role) {
  print(role);
  return Container(
    child: ListView.builder(
      itemCount: role.length,
      itemBuilder: (context, index) {
        UsersModel user = role[index];

        return ContactsManagementList(
          name: user.name,
          surname: user.surname,
          company: user.position,
          id: '',
        );
      },
    ),
  );
}
