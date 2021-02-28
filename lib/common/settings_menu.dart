import 'package:flutter/material.dart';
import 'package:mi_promotora/pages/change_password_page.dart';

import '../main.dart';

class PopupButton extends StatefulWidget {
  PopupButton({Key key}) : super(key: key);

  @override
  _PopupButtonState createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 15, 8, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Cambiar mi contraseña',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.black, fontSize: 15.1),
                  ),
                  Icon(
                    Icons.settings_rounded,
                    color: MiPromotora().primaryDark,
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordPage(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
