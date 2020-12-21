import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';

class ServicesView extends StatefulWidget {
  final String name;
  ServicesView({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  @override
  Widget build(BuildContext context) {
    return _roundedButton(
        Colors.white, Icons.airport_shuttle_outlined, widget.name);
  }

  Widget _roundedButton(Color color, IconData icono, String texto) {
    return ClipRect(
      child: Container(
        height: 150.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: PromotoraApp().primaryDark,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            CircleAvatar(
              backgroundColor: color,
              radius: 30.0,
              child: Icon(icono, color: Colors.black, size: 30.0),
            ),
            Text(
              texto,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    );
  }
}
