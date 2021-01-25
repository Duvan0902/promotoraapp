import 'package:flutter/material.dart';
import 'package:MiPromotora/main.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Intentar de nuevo',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: MiPromotora().primaryDark, fontSize: 16),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
