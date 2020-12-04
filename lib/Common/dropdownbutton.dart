import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  DropButton({Key key}) : super(key: key);

  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String _value;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      color: Color.fromRGBO(243, 243, 243, 1),
      child: DropdownButton<String>(
        iconSize: 0.0,
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        items: [
          DropdownMenuItem<String>(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Venta 1',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black45, fontSize: 14),
              ),
            ),
            value: 'one',
          ),
          DropdownMenuItem<String>(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Venta 2',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black45, fontSize: 14),
              ),
            ),
            value: 'two',
          ),
          DropdownMenuItem<String>(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Venta 3',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black45, fontSize: 14),
              ),
            ),
            value: 'three',
          ),
        ],
        onChanged: (String value) {
          setState(() {
            _value = value;
          });
        },
        hint: Container(
          padding: EdgeInsets.all(10),
          child: Align(
            child: Text(
              'Escoge el tipo de venta',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black45, fontSize: 14),
            ),
          ),
        ),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black45, fontSize: 14),
        value: _value,
      ),
    );
  }
}
