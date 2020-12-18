import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/frequent_questions.dart';
import 'package:promotoraapp/Model/categories_model.dart';

class CategoriesList extends StatelessWidget {
  final List<FaqCategoriesModel> categories;

  CategoriesList({@required this.categories});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return FrequentQuestions(
            category: categories[index],
          );
        },
      ),
    );
  }
}
