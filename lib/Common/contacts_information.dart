import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/contacts_management.dart';
import 'package:promotoraapp/main.dart';

class ContactsInformationList extends StatefulWidget {
  final ContactsManagementList data;

  const ContactsInformationList({Key key, this.data}) : super(key: key);

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
                      'name:${data.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'name:${data.surname}',
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
                    'name:${data.company}',
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
        /* Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            child: Text(
              'name:${data.description}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black45, fontSize: 16),
            ),
          ),
        ),*/
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('name:${data.phone1}'),
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
            child: Container(child: Text('name:${data.email}')),
          ),
        ),
      ],
    );
  }
}
