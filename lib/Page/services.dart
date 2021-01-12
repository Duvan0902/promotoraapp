import 'package:flutter/material.dart';
import 'package:promotoraapp/Model/atac_model.dart';
import 'package:promotoraapp/Page/atac_page.dart';
import 'package:promotoraapp/main.dart';

class ServicesView extends StatefulWidget {
  final AtacModel atac;
  ServicesView({
    Key key,
    this.atac,
  }) : super(key: key);

  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  @override
  Widget build(BuildContext context) {
    return _roundedButton(
        Colors.white, Icons.airport_shuttle_outlined, widget.atac.name);
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
                icon: Image.network(
                  'http://66.228.51.95:1337' + widget.atac.icon.url,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AtacPage(
                        categoriesAtac: widget.atac.atacCategories,
                        atac: widget.atac,
                      ),
                    ),
                  );
                },
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
