import 'package:flutter/material.dart';
import 'package:mi_promotora/main.dart';

import '../main.dart';

class BottomList extends StatelessWidget {
  final String title;

  final String route;

  const BottomList({
    Key key,
    @required this.title,
    @required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.fromLTRB(20, 15, 8, 15)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return Colors.grey;
            return Colors.white; // Defer to the widget's default.
          }),
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                this.title,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black, fontSize: 15.1),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: MiPromotora().primaryDark,
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, this.route);
        });
  }
}
