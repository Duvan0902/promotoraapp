import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';

class ExpansionCard extends StatefulWidget {
  final String questions;
  final String answer;

  final Function() onChanged;
  final bool highlight;

  const ExpansionCard({
    Key key,
    @required this.questions,
    @required this.answer,
    this.onChanged,
    this.highlight = false,
  })  : assert(questions != null),
        super(key: key);

  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.highlight ? Colors.white : Colors.black;
    Color iconColor = widget.highlight ? Colors.white : PromotoraApp().accent;

    var expansionTile = ExpansionTile(
      trailing: _expanded
          ? Icon(
              Icons.remove_circle_outline,
              color: iconColor,
            )
          : Icon(
              Icons.add_circle_outline,
              color: iconColor,
            ),
      title: widget.questions != null
          ? Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                widget.questions,
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black45, fontSize: 15),
              ),
            )
          : false,
      children: <Widget>[
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.fromLTRB(16, 10, 60, 10),
          child: Text(
            widget.answer,
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black54, fontSize: 15),
          ),
        )
      ],
      onExpansionChanged: (changed) {
        setState(() {
          _expanded = changed;
        });
        if (widget.onChanged != null) {
          widget.onChanged.call();
        }
      },
      initiallyExpanded: _expanded,
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: widget.highlight ? PromotoraApp().primaryLight : Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: expansionTile,
      ),
    );
  }
}
