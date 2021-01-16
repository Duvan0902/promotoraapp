import 'package:flutter/material.dart';
import 'package:promotoraapp/models/categories_model.dart';
import 'package:promotoraapp/pages/faq_plugin.dart';

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
