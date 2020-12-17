import 'package:flutter/material.dart';
import 'package:promotoraapp/Page/answers_page.dart';
import 'package:promotoraapp/main.dart';

class FrenquentQuestions extends StatefulWidget {
  final String category;

  FrenquentQuestions({Key key, this.category}) : super(key: key);

  @override
  _FrenquentQuestionsState createState() => _FrenquentQuestionsState();
}

class _FrenquentQuestionsState extends State<FrenquentQuestions> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.category,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black, fontSize: 15.1),
              ),
              Icon(
                Icons.ac_unit,
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
            MaterialPageRoute(builder: (context) => AnswersPage()),
          );
        });
  }
}
