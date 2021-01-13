import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:promotoraapp/Model/categories_model.dart';
import 'package:promotoraapp/Page/faq_list.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/provider/categories_provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class FaqCategoriesPage extends StatefulWidget {
  final FaqCategoriesModel category;
  const FaqCategoriesPage({Key key, this.category}) : super(key: key);

  @override
  _FaqCategoriesPageState createState() => _FaqCategoriesPageState();
}

class _FaqCategoriesPageState extends State<FaqCategoriesPage> {
  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
      title: new Text('Preguntas Frecuentes'),
      actions: [searchBar.getSearchAction(context)],
      backgroundColor: Colors.grey[900],
    );
  }

  _FaqCategoriesPageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: searchBar.build(context),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: categories(context),
              ),
              Container(
                child: _chat(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categories(context) {
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

Widget _chat(context) {
  return Container(
    child: Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.fromLTRB(0, 0, 20, 30),
      child: FloatingActionButton(
        backgroundColor: Colors.pink[400],
        elevation: 5.0,
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ),
  );
}
