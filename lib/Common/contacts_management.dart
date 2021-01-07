import 'package:flutter/material.dart';
import 'package:promotoraapp/Page/contact_information_page.dart';
import 'package:promotoraapp/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsManagementList extends StatefulWidget {
  final String name;
  final String surname;
  final String company;
  final String description;
  final String email;
  final String phone1;
  final String phone2;

  ContactsManagementList({
    Key key,
    @required this.name,
    @required this.surname,
    @required this.company,
    @required this.description,
    @required this.email,
    @required this.phone1,
    @required this.phone2,
  }) : super(key: key);

  @override
  _ContactsManagementListState createState() => _ContactsManagementListState();
}

class _ContactsManagementListState extends State<ContactsManagementList> {
  String name = '';
  String surme = '';
  String company = '';
  String description = '';
  String email = '';
  String phone = '';
  String phone1 = '';
  @override
  Widget build(BuildContext context) {
    var listTile = Column(
      children: [
        Row(
          children: <Widget>[
            Text(
              widget.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.surname,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          widget.company,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 16),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 2),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              listTile,
              IconButton(
                icon: Icon(
                  Icons.call_outlined,
                ),
                color: PromotoraApp().primaryDark,
                iconSize: 30,
                onPressed: () => _launchURL(widget.phone1),
              )
            ],
          ),
        ),
        onPressed: () {
          name = widget.name;
          surme = widget.surname;
          company = widget.company;
          description = widget.description;
          email = widget.email;
          phone = widget.phone1;
          phone1 = widget.phone2;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactInformationPage(
                  name, surme, company, description, email, phone, phone1),
            ),
          );
        },
      ),
    );
  }

  _launchURL(phone) async {
    if (await canLaunch('tel:' + phone)) {
      await launch('tel:' + phone);
    } else {
      throw 'Could not launch $phone';
    }
  }
}
