import 'package:flutter/material.dart';
import 'package:promotoraapp/common/drawer.dart';
import 'package:promotoraapp/models/documents_model.dart';
import 'package:promotoraapp/providers/document_provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:string_similarity/string_similarity.dart';

import 'document_View.dart';

class DocumentsPage extends StatefulWidget {
  final DocumentsModel document;
  const DocumentsPage({Key key, this.document}) : super(key: key);

  @override
  _DocumentsPageState createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  String searchText;
  SearchBar searchBar;
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomDrawer(),
            ),
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

  _DocumentsPageState() {
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
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              _posterTitle(context),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: _documentItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        'Te brindamos material de apoyo que te ayudará en tu proceso.',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Colors.black, fontSize: 17),
      ),
    );
  }

  Widget _documentItems() {
    final servicesProvider = DocumentsProvider();
    return Container(
      child: FutureBuilder(
        future: servicesProvider.getDocuments(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _documentList(snapshot.data);
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

  Widget _documentList(List<DocumentsModel> documents) {
    print("Search text is: $searchText");

    List<DocumentsModel> filteredList;

    if (searchText != "" && searchText != null) {
      filteredList = documents.where((document) {
        bool isSimilar = document.title.similarityTo(searchText) > 0.3;
        bool isContained = document.title
            .toLowerCase()
            .contains(this.searchText.toLowerCase());

        return isSimilar || isContained;
      }).toList();
    } else {
      filteredList = documents;
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: GridView.builder(
        itemCount: filteredList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return DocumentView(
            doc: filteredList[index],
          );
        },
      ),
    );
  }
}
