import 'package:flutter/material.dart';
import 'package:mi_promotora/pages/change_password_page.dart';
import 'package:mi_promotora/pages/documents_page.dart';
import 'package:mi_promotora/pages/faq_categories_page.dart';
import 'package:mi_promotora/pages/sale_page.dart';
import 'package:mi_promotora/main.dart';

import '../main.dart';
import '../pages/home_page.dart';
import 'custom_webView.dart';

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
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(20, 15, 8, 15),
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
        color: Colors.white,
        disabledTextColor: Colors.grey,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: this.route,
                routes: {
                  'sale': (BuildContext context) => SalePage(),
                  'questions': (BuildContext context) => FaqCategoriesPage(),
                  'Documents': (BuildContext context) => DocumentsPage(),
                  'Porchat': (BuildContext context) => CustomWebView(),
                  'HomePage': (BuildContext context) => HomePage(),
                  'LoginPage': (BuildContext context) => MiPromotora(),
                  'change': (BuildContext context) => ChangePasswordPage(),
                },
              ),
            ),
          );
        });
  }
}
