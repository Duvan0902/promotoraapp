import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/contacts_information.dart';
import 'package:promotoraapp/Model/contacts_model.dart';

class ContactsInformation extends StatelessWidget {
  final List<ContactsModel> contacts;

  ContactsInformation({@required this.contacts});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactsInformationList(
            name: contacts[index].name,
            surname: contacts[index].surname,
            company: contacts[index].company,
            id: contacts[index].company,
            email: contacts[index].email,
            description: contacts[index].description,
            phone1: contacts[index].phone1,
            phone2: contacts[index].phone2,
          );
        },
      ),
    );
  }
}
