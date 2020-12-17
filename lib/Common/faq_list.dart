import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/contacts_management.dart';
import 'package:promotoraapp/Common/questions_answer.dart';
import 'package:promotoraapp/Model/categories_model.dart';
import 'package:promotoraapp/Model/faq_model.dart';

class FaqList extends StatelessWidget {
  final List<FaqModel> contacts;

  FaqList({@required this.contacts});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ExpansionCard(
              questions: contacts[index].answer,
              answer: contacts[index].question);
        },
      ),
    );
  }
}
