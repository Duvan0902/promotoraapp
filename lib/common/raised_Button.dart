import 'package:flutter/material.dart';
import 'package:promotoraapp/pages/documents_page.dart';
import 'package:promotoraapp/pages/faq_categories_page.dart';
import 'package:promotoraapp/pages/sale_page.dart';
import 'package:promotoraapp/main.dart';

class BottomList extends StatelessWidget {
  final String title;
  final IconButton icon;

  final String route;

  const BottomList({
    Key key,
    @required this.title,
    @required this.route,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(20, 00, 8, 5),
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
              IconButton(
                icon: this.icon,
                color: PromotoraApp().primaryDark,
                onPressed: () {},
              ),
            ],
          ),
        ),
        color: Colors.white,
        disabledTextColor: Colors.grey,
        onPressed: () {
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
                },
              ),
            ),
          );
        });
  }
}
