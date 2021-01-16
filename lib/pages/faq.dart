import 'package:flutter/material.dart';
import 'package:promotoraapp/models/categories_model.dart';
import 'package:promotoraapp/pages/faq_page.dart';
import 'package:promotoraapp/main.dart';

class FrequentQuestionsPage extends StatefulWidget {
  final FaqCategoriesModel category;

  FrequentQuestionsPage({Key key, this.category}) : super(key: key);

  @override
  _FrequentQuestionsPageState createState() => _FrequentQuestionsPageState();
}

class _FrequentQuestionsPageState extends State<FrequentQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(23, 13, 20, 1),
      child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.category.category,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.black, fontSize: 15.1),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
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
                builder: (context) => FaqPage(faqlist: widget.category.faq),
              ),
            );
          }),
    );
  }
}
