import 'package:flutter/material.dart';
import 'package:promotoraapp/Model/education_model.dart';
import 'package:promotoraapp/main.dart';

class EducationView extends StatefulWidget {
  final EducationModel education;
  EducationView({Key key, this.education}) : super(key: key);

  @override
  _EducationViewState createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  @override
  Widget build(BuildContext context) {
    return _educationItems(
      Colors.white,
      Icons.airport_shuttle_outlined,
    );
  }

  Widget _educationItems(Color color, IconData icono) {
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
                  color: PromotoraApp().primaryDark,
                  icon: Image.network(
                    'http://66.228.51.95:1337' + widget.education.icon.url,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                  onPressed: () {}),
            ),
            Text(
              widget.education.module,
              style: Theme.of(context)
                  .textTheme
                  .headline3
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