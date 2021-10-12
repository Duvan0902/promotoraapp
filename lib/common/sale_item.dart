import 'package:flutter/material.dart';
import 'package:mi_promotora/main.dart';

class FlexibleExpansionCard extends StatefulWidget {
  final Widget header;
  final Widget detail;
  final Function() onChanged;
  final bool highlight;

  const FlexibleExpansionCard({
    Key key,
    @required this.header,
    @required this.detail,
    this.onChanged,
    this.highlight = false,
  })  : assert(header != null),
        super(key: key);

  @override
  _FlexibleExpansionCardState createState() => _FlexibleExpansionCardState();
}

class _FlexibleExpansionCardState extends State<FlexibleExpansionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    Color iconColor =
        widget.highlight ? Colors.white : MiPromotora().primaryDark;

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
      title: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: widget.header,
      ),
      children: <Widget>[
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.fromLTRB(16, 10, 60, 10),
          child: widget.detail,
        ),
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
      color: widget.highlight ? MiPromotora().primaryLight : Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: expansionTile,
      ),
    );
  }
}
