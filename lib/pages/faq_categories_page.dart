import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:promotoraapp/common/bottom_chat.dart';
import 'package:promotoraapp/models/categories_model.dart';
import 'package:promotoraapp/pages/home_page.dart';
import 'package:promotoraapp/providers/categories_provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:string_similarity/string_similarity.dart';
import 'faq.dart';

class FaqCategoriesPage extends StatefulWidget {
  final FaqCategoriesModel category;
  const FaqCategoriesPage({Key key, this.category}) : super(key: key);

  @override
  _FaqCategoriesPageState createState() => _FaqCategoriesPageState();
}

class _FaqCategoriesPageState extends State<FaqCategoriesPage> {
  final categoriesProvider = CategoriesProvider();
  String searchText;
  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
      title: new Text('Preguntas Frecuentes'),
      actions: [searchBar.getSearchAction(context)],
      backgroundColor: Colors.grey[900],
    );
  }

  void clearSearch() {
    setState(() {
      searchText = "";
    });
  }

  void search(String value) {
    setState(() {
      searchText = value;
    });
  }

  _FaqCategoriesPageState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onChanged: search,
        onCleared: clearSearch,
        onClosed: clearSearch,
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
              BottomChat(),
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
            return _categoriesList(snapshot.data);
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

  Widget _categoriesList(List<FaqCategoriesModel> categories) {
    print("Search text is: $searchText");

    List<FaqCategoriesModel> filteredList;

    if (searchText != "" && searchText != null) {
      filteredList = categories.where((category) {
        bool isSimilar = category.category.similarityTo(searchText) > 0.3;
        bool isContained = category.category
            .toLowerCase()
            .contains(this.searchText.toLowerCase());

        return isSimilar || isContained;
      }).toList();
    } else {
      filteredList = categories;
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return FrequentQuestionsPage(
            category: filteredList[index],
          );
        },
      ),
    );
  }
}
