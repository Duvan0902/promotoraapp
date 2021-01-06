import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/document.dart';
import 'package:promotoraapp/Model/documents_model.dart';

class DocumentList extends StatelessWidget {
  final List<DocumentsModel> documents;

  DocumentList({@required this.documents});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: documents.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return DocumentView(
          document: documents[index],
        );
      },
    );
  }
}
