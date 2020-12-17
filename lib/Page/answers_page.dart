import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/bottom_chat.dart';
import 'package:promotoraapp/Common/questions_answer.dart';
import 'package:promotoraapp/Model/faq_model.dart';
import 'package:promotoraapp/Model/questions_model.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/provider/questions_provider.dart';

class AnswersPage extends StatefulWidget {
  const AnswersPage({
    Key key,
  }) : super(key: key);

  @override
  _AnswersPageState createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
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
    QuestionsProvider questionsProvider = QuestionsProvider();
    return Container(
      child: FutureBuilder(
        future: questionsProvider.getQuestions(),
        builder:
            (BuildContext context, AsyncSnapshot<QuestionsModel> snapshot) {
          if (snapshot.hasData) {
            QuestionsModel event = snapshot.data;
            print(event);
            List<FaqModel> documents = event.faq;

            return _sections(context, documents);
          } else {
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _sections(context, List<FaqModel> documets) {
    print(documets);
    return Container(
      child: ListView.builder(
        itemCount: documets.length,
        itemBuilder: (context, index) {
          FaqModel document = documets[index];

          return ExpansionCard(
            questions: document.question,
            answer: document.answer,
          );
        },
      ),
    );
  }
}
