import 'package:flutter/material.dart';
import 'package:promotoraapp/Page/users_information_page.dart';
import 'package:promotoraapp/main.dart';

class UsersManagementList extends StatefulWidget {
  final String name;
  final String surname;
  final String position;
  final String description;
  final String email;
  final String phone1;
  final String phone2;

  UsersManagementList({
    Key key,
    @required this.name,
    @required this.surname,
    @required this.position,
    @required this.description,
    @required this.email,
    @required this.phone1,
    @required this.phone2,
  }) : super(key: key);

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
        Text(
          widget.position,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 16),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.fromLTRB(0, 00, 0, 8),
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
                onPressed: () {},
              )
            ],
          ),
        ),
        onPressed: () {
          name = widget.name;
          surname = widget.surname;
          position = widget.position;
          description = widget.description;
          email = widget.email;
          phone1 = widget.phone1;
          phone2 = widget.phone2;

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
}
