import 'package:flutter/material.dart';
import 'package:MiPromotora/models/documents_model.dart';
import 'package:MiPromotora/main.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentView extends StatefulWidget {
  final DocumentsModel doc;

  DocumentView({
    Key key,
    this.doc,
  }) : super(key: key);

  @override
  _DocumentViewState createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  Widget build(BuildContext context) {
    return _roundedButton(
      Color.fromRGBO(243, 243, 243, 1),
      Icons.airport_shuttle_outlined,
      widget.doc.title,
    );
  }

  Widget _roundedButton(
    Color color,
    IconData icono,
    String text,
  ) {
    return ClipRect(
      child: Container(
        height: 150.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            CircleAvatar(
              backgroundColor: color,
              radius: 30.0,
              child: IconButton(
                color: MiPromotora().primaryDark,
                icon: Icon(Icons.file_download),
                iconSize: 30,
                onPressed: () => _launchURL(widget.doc.file.url),
              ),
            ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch('http://66.228.51.95:1337' + url)) {
    await launch('http://66.228.51.95:1337' + url);
  } else {
    throw 'Could not launch $url';
  }
}
