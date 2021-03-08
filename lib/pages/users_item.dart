import 'package:flutter/material.dart';
import 'package:mi_promotora/models/user_model.dart';
import 'package:mi_promotora/pages/users_information_page.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/utils/launch_url.dart';
import 'package:recase/recase.dart';

class UserInformationItem extends StatefulWidget {
  final UserModel user;

  UserInformationItem({Key key, this.user}) : super(key: key);

  @override
  _UserInformationItemState createState() => _UserInformationItemState();
}

class _UserInformationItemState extends State<UserInformationItem> {
  @override
  Widget build(BuildContext context) {
    var listTile = Flexible(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Text(
              widget.user.name.titleCase,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.user.surname.titleCase,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          widget.user.position.titleCase,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 15),
        ),
      ],
    ));

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 3, 15),
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
                  onPressed: () => callPhone(widget.user.phone1),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UsersInformationPage(widget.user),
              ),
            );
          },
        ),
      ),
    );
  }
}
