import 'package:flutter/material.dart';
import 'package:mi_promotora/models/documents_model.dart';
import 'package:mi_promotora/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:global_configuration/global_configuration.dart';

class DocumentView extends StatefulWidget {
  final DocumentsModel doc;

  DocumentView({
    Key key,
    this.doc,
  }) : super(key: key);

  @override
  _DocumentViewState createState() => _DocumentViewState();
}

final String _url = GlobalConfiguration().getValue("api_url");

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
    return InkWell(
      child: ClipRect(
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
      ),
      onTap: () => _launchURL(widget.doc.file.url),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(_url + url)) {
    await launch(_url + url);
  } else {
    throw 'Could not launch $url';
  }
}
