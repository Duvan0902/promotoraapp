import 'package:flutter/material.dart';
import 'package:MiPromotora/main.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ContactInformationPage extends StatefulWidget {
  String name;
  String surname;
  String company;
  String description;
  String email;
  String phone;
  String phone1;
  ContactInformationPage(this.name, this.surname, this.company,
      this.description, this.email, this.phone, this.phone1);

  @override
  _ContactInformationPageState createState() => _ContactInformationPageState();
}

class _ContactInformationPageState extends State<ContactInformationPage> {
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
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 75),
            child: Icon(Icons.ac_unit),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: _contactsTitle(context),
        ),
      ),
    );
  }

  Widget _contactsTitle(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
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
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.company,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 40, 120, 40),
              child: Text(
                widget.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black45, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.phone),
                  IconButton(
                    icon: Icon(
                      Icons.call_outlined,
                    ),
                    color: MiPromotora().primaryDark,
                    iconSize: 30,
                    onPressed: () => _launchURL(widget.phone),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.phone1),
                  IconButton(
                    icon: Icon(
                      Icons.call_outlined,
                    ),
                    color: MiPromotora().primaryDark,
                    iconSize: 30,
                    onPressed: () => _launchURL2(widget.phone1),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 130, 20),
              child: Container(
                child: Text(
                  widget.email,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ],
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

  _launchURL2(phone2) async {
    if (await canLaunch('tel:' + phone2)) {
      await launch('tel:' + phone2);
    } else {
      throw 'Could not launch $phone2';
    }
  }
}
