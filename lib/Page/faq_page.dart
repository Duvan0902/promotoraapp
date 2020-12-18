import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/frequent_questions.dart';
import 'package:promotoraapp/Common/questions_answer.dart';
import 'package:promotoraapp/Model/faq_model.dart';

// ignore: must_be_immutable
class FaqPage extends StatefulWidget {
  final List<FaqModel> faqlist;

  FaqPage({Key key, @required this.faqlist}) : super(key: key);

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey[900],
          title: Text(
            "Preguntas Frecuentes",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Container(
          child: _posterTitle(context),
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
    return _answer(context, widget.faqlist);
  }

  Widget _answer(context, List<FaqModel> faqlist) {
    print(faqlist);
    return Container(
      child: ListView.builder(
        itemCount: faqlist.length,
        itemBuilder: (context, index) {
          FaqModel document = faqlist[index];

          return ExpansionCard(
            questions: document.question,
            answer: document.answer,
          );
        },
      ),
    );
  }
}
