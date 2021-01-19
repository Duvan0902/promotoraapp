import 'package:flutter/material.dart';
import 'package:promotoraapp/models/users_model.dart';
import 'package:promotoraapp/pages/users_information_page.dart';
import 'package:promotoraapp/main.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersManagementList extends StatefulWidget {
  final UsersModel user;

  UsersManagementList({Key key, this.user}) : super(key: key);

  @override
  _UsersManagementListState createState() => _UsersManagementListState();
}

class _UsersManagementListState extends State<UsersManagementList> {
  String name = '';
  String surname = '';
  String position = '';
  String description = '';
  String email = '';
  String phone1 = '';
  String phone2 = '';
  @override
  Widget build(BuildContext context) {
    var listTile = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Text(
              widget.user.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.user.surname,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
        Text(
          widget.user.position,
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
                onPressed: () => _launchURL(widget.user.phone1),
              )
            ],
          ),
        ),
        onPressed: () {
          name = widget.user.name;
          surname = widget.user.surname;
          position = widget.user.position;
          description = widget.user.description;
          email = widget.user.email;
          phone1 = widget.user.phone1;
          phone2 = widget.user.phone2;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UsersInformationPage(
                  name, surname, position, description, email, phone1, phone2),
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
