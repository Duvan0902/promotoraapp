import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/Card_information.dart';
import 'package:promotoraapp/main.dart';

class ContactInformationPage extends StatelessWidget {
  const ContactInformationPage({Key key}) : super(key: key);

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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              child: _posterTitle(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
    return GeneralCard();
  }
}
