import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/contacts_information_list.dart';

import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/provider/contacts_provider.dart';

class UsersInformationPage extends StatelessWidget {
  const UsersInformationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[900],
          title: new Text(
            "Contactos",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 20),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PromotoraApp(),
                ),
              );
            },
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 75),
            child: Icon(Icons.ac_unit),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            child: _posterTitle(context),
          ),
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
    final contactProvider = ContactsProvider();
    return Container(
      child: FutureBuilder(
        future: contactProvider.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ContactsInformation(contacts: snapshot.data);
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
