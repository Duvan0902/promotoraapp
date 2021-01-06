import 'package:flutter/material.dart';
import 'package:promotoraapp/Model/documents_model.dart';
import 'package:promotoraapp/main.dart';

class DocumentView extends StatefulWidget {
  final DocumentsModel document;
  DocumentView({
    Key key,
    this.document,
  }) : super(key: key);

  @override
  _DocumentViewState createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  Widget build(BuildContext context) {
    return _roundedButton(
        Colors.white, Icons.airport_shuttle_outlined, widget.document.title);
  }

  Widget _roundedButton(Color color, IconData icono, String text) {
    return ClipRect(
      child: Container(
        height: 150.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: PromotoraApp().primaryDark,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            CircleAvatar(
              backgroundColor: color,
              radius: 30.0,
              child: IconButton(
                color: Colors.black,
                icon: Icon(Icons.download_done_outlined),
                onPressed: () {},
              ),
            ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    );
  }
}
