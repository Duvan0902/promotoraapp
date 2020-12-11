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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
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
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            child: Text(
              widget.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black45, fontSize: 16),
            ),
          ),
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
                  color: PromotoraApp().primaryDark,
                  iconSize: 30,
                  onPressed: () {},
                )
              ],
            ),
          ),
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
                Text('sin numero'),
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
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(50, 20, 59, 20),
            child: Container(child: Text(widget.email)),
          ),
        ),
      ],
    );
  }
}
