import 'package:flutter/material.dart';

class TotalBox extends StatelessWidget {
  final String lefttext;
  final String rigthtext;
  final Color background;
  final Color fontcolor;

  const TotalBox(
      {Key key, this.lefttext, this.rigthtext, this.background, this.fontcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      color: this.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              this.lefttext,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: this.fontcolor),
            ),
            Text(
              this.rigthtext,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: this.fontcolor),
            )
          ],
        ),
      ),
    );
  }
}
