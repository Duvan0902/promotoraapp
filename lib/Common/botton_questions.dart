import 'package:flutter/material.dart';
import 'package:promotoraapp/Page/frequent%20questions.dart';
import 'package:promotoraapp/Page/sale_page.dart';
import 'package:promotoraapp/main.dart';

class BottomQuestions extends StatelessWidget {
  final String title;
  final String route;

  const BottomQuestions({
    Key key,
    @required this.title,
    @required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RaisedButton(
        child: Container(
          height: size.height * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                this.title,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 34,
                color: PromotoraApp().primaryDark,
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
                        'questions': (BuildContext context) => QuestionsPage(),
                      },
                    )),
          );
        });
  }
}
