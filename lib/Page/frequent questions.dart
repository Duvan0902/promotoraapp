import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/bottom_chat.dart';
import 'package:promotoraapp/Common/frequent_questions.dart';
import 'package:promotoraapp/Model/questions_model.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/provider/questions_provider.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({
    Key key,
  }) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PromotoraApp(),
                ),
              );
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
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(25.0),
                child: _posterTitle(context),
              ),
              SizedBox(height: 55),
              _chat(context)
            ],
          ),
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

            return Container(
              child: FrenquentQuestions(
                category: event.category,
              ),
            );
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

  Widget _chat(context) {
    return BottomChat();
  }
}
