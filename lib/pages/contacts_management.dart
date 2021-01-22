import 'package:flutter/material.dart';
import 'package:MiPromotora/models/contacts_model.dart';
import 'package:MiPromotora/pages/contact_information_page.dart';
import 'package:MiPromotora/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsManagementList extends StatefulWidget {
  final ContactsModel contacts;

  ContactsManagementList({Key key, this.contacts}) : super(key: key);

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Text(
              widget.contacts.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.contacts.surname,
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
          widget.contacts.company,
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
                color: MiPromotora().primaryDark,
                iconSize: 30,
                onPressed: () => _launchURL(widget.contacts.phone1),
              )
            ],
          ),
        ),
        onPressed: () {
          name = widget.contacts.name;
          surme = widget.contacts.surname;
          company = widget.contacts.company;
          description = widget.contacts.description;
          email = widget.contacts.email;
          phone = widget.contacts.phone1;
          phone1 = widget.contacts.phone2;

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
