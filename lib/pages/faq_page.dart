import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mi_promotora/common/questions_answer.dart';
import 'package:mi_promotora/models/faq_model.dart';

// ignore: must_be_immutable
class FaqPage extends StatefulWidget {
  final List<FaqModel> faqlist;
  final String title;

  FaqPage({Key key, @required this.faqlist, @required this.title})
      : super(key: key);

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[900],
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: _posterTitle(context),
            ),
          ],
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
      padding: EdgeInsets.all(10),
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
