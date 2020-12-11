import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';

class ContactsInformationList extends StatefulWidget {
  final String id;
  final String name;
  final String surname;
  final String company;
  final String description;
  final String email;
  final String phone1;
  final String phone2;

  const ContactsInformationList({
    Key key,
    @required this.id,
    @required this.name,
    @required this.surname,
    @required this.company,
    @required this.description,
    @required this.email,
    @required this.phone1,
    @required this.phone2,
  }) : super(key: key);

  @override
  _ContactsInformationListState createState() =>
      _ContactsInformationListState();
}

class _ContactsInformationListState extends State<ContactsInformationList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [Text(widget.name), Text(widget.surname)],
              ),
              Text(widget.company),
            ],
          ),
        ),
        Card(
          child: Text(widget.description),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.phone1),
            IconButton(
              icon: Icon(
                Icons.call_outlined,
              ),
              color: PromotoraApp().primaryDark,
              iconSize: 30,
              onPressed: () {},
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.phone2),
            IconButton(
              icon: Icon(
                Icons.call_outlined,
              ),
              color: PromotoraApp().primaryDark,
              iconSize: 30,
              onPressed: () {},
            )
          ],
        ),
        Card(
          child: Text(widget.email),
        ),
      ],
    );
  }
}
