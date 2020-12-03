import 'package:flutter/material.dart';

class BottomList extends StatelessWidget {
  final String title;
  final String title2;

  const BottomList({
    Key key,
    @required this.title,
    @required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    this.title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.black45, fontSize: 16),
                  ),
                ),
                Container(
                  child: Text(
                    this.title2,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.cyan[300], fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 50,
                    color: Colors.cyan[300],
                  ),
                ),
              ],
            ),
          ),
          color: Colors.white,
          disabledTextColor: Colors.grey,
          onPressed: () {}),
    );
  }
}
