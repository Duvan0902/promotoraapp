import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/random_color.dart';
import 'package:promotoraapp/Model/education_model.dart';
import 'package:promotoraapp/Page/education_complement_page.dart';
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
    return ClipRect(
      child: Container(
        height: 150.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: UniqueColorGenerator.getColor(),
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
              backgroundColor: Colors.white,
              radius: 30.0,
              child: IconButton(
                  color: PromotoraApp().primaryDark,
                  icon: Image.network(
                    'http://66.228.51.95:1337' + widget.education.icon.url,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EducationComplementPage(
                            complement: widget.education),
                      ),
                    );
                  }),
            ),
            Text(
              widget.education.module,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
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
