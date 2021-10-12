import 'package:flutter/material.dart';
import 'package:mi_promotora/models/categories_model.dart';
import 'package:mi_promotora/pages/faq_page.dart';
import 'package:mi_promotora/main.dart';

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
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return Colors.grey;
            return Colors.white; // Defer to the widget's default.
          }),
        ),
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
                color: MiPromotora().primaryDark,
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FaqPage(
                  faqlist: widget.category.faq,
                  title: widget.category.category),
            ),
          );
        },
      ),
    );
  }
}
