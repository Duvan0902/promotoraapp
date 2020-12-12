import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/users_management.dart';
import 'package:promotoraapp/Model/users_model.dart';

class UsersList extends StatelessWidget {
  final List<UsersModel> contacts;

  UsersList({@required this.contacts});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return UsersManagementList(
            name: contacts[index].name,
            surname: contacts[index].surname,
            position: contacts[index].position,
            description: contacts[index].description,
            email: contacts[index].email,
            phone1: contacts[index].phone1,
            phone2: contacts[index].phone2,
          );
        },
      ),
    );
  }
}
