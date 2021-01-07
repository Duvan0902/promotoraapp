import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/document_list.dart';
import 'package:promotoraapp/Model/documents_model.dart';
import 'package:promotoraapp/provider/document_provider.dart';

class DocumentsPage extends StatelessWidget {
  final List<DocumentsModel> document;
  const DocumentsPage({Key key, this.document}) : super(key: key);

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
            "Documentos",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
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
            return DocumentList(documents: snapshot.data);
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
