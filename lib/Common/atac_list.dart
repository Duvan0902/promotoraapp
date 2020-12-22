import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/questions_answer.dart';
import 'package:promotoraapp/Model/atac_model.dart';

class FaqList extends StatelessWidget {
  final List<AtacModel> contacts;

  FaqList({@required this.contacts});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ExpansionCard(
              questions: contacts[index].atacCategory,
              answer: contacts[index].atacCategory);
        },
      ),
    );
  }
}
