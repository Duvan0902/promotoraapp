import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:promotoraapp/Common/questions_list.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/provider/categories_provider.dart';

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
        body: Container(
          padding: const EdgeInsets.all(25.0),
          child: _posterTitle(context),
        ),

        /*_chat(context)*/
      ),
    );
  }

  Widget _posterTitle(context) {
    final categoriesProvider = CategoriesProvider();
    return Container(
      child: FutureBuilder(
        future: categoriesProvider.getCategories(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CategoriesList(categories: snapshot.data);
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
}
/* Widget _chat(context) {
    return BottomChat();
  }
}*/
