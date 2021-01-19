import 'package:flutter/material.dart';
import 'package:promotoraapp/common/drawer.dart';
import 'package:promotoraapp/models/contacts_model.dart';
import 'package:promotoraapp/models/users_model.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/providers/contacts_provider.dart';
import 'package:promotoraapp/providers/users_provider.dart';
import 'package:string_similarity/string_similarity.dart';

import 'contacts_management.dart';
import 'users_management.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  int _selectedTab = 0;

  Widget _currentWidget;
  String searchText;

  SearchBar searchBar;
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: new Text('Buscar Contactos'),
      actions: [searchBar.getSearchAction(context)],
      backgroundColor: Colors.grey[900],
    );
  }

  void clearSearch() {
    setState(() {
      searchText = "";
    });
  }

  void search(String value) {
    setState(() {
      searchText = value;
    });
  }

  _ContactsPageState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onChanged: search,
        onCleared: clearSearch,
        onClosed: clearSearch,
        buildDefaultAppBar: buildAppBar);
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
        drawer: CustomDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
    double width = (MediaQuery.of(context).size.width / 2) - 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: selected ? PromotoraApp().primaryDark : Colors.white,
          border: Border.all(
            color: Color.fromRGBO(243, 243, 243, 1),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: selected ? Colors.black : Colors.black,
              fontWeight: FontWeight.w800),
        ),
        width: width,
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
            return _userList(snapshot.data);
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

  Widget _userList(List<UsersModel> users) {
    print("Search text is: $searchText");

    List<UsersModel> filteredListUser;

    if (searchText != "" && searchText != null) {
      filteredListUser = users.where((contact) {
        bool isSimilar = contact.name.similarityTo(searchText) > 0.3;
        bool isSimilarSurname = contact.surname.similarityTo(searchText) > 0.3;
        bool isContained =
            contact.name.toLowerCase().contains(this.searchText.toLowerCase());

        return isSimilar || isSimilarSurname || isContained;
      }).toList();
    } else {
      filteredListUser = users;
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: filteredListUser.length,
        itemBuilder: (context, index) {
          return UsersManagementList(
            user: filteredListUser[index],
          );
        },
      ),
    );
  }

  Widget managementList(context) {
    final contactProvider = ContactsProvider();
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 20, 30),
      child: FutureBuilder(
        future: contactProvider.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _contactsList(
              snapshot.data,
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

  Widget _contactsList(List<ContactsModel> contacts) {
    print("Search text is: $searchText");

    List<ContactsModel> filteredList;

    if (searchText != "" && searchText != null) {
      filteredList = contacts.where((contact) {
        bool isSimilar = contact.name.similarityTo(searchText) > 0.3;
        bool isSimilarSurname = contact.surname.similarityTo(searchText) > 0.3;
        bool isContained =
            contact.name.toLowerCase().contains(this.searchText.toLowerCase());

        return isSimilar || isSimilarSurname || isContained;
      }).toList();
    } else {
      filteredList = contacts;
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return ContactsManagementList(
            contacts: filteredList[index],
          );
        },
      ),
    );
  }
}
