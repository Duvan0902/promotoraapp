import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/models/goals_model.dart';
import 'package:promotoraapp/pages/Top_ten_page.dart';

class GoaldInformationPage extends StatefulWidget {
  final GoalsModel goasl;
  GoaldInformationPage({Key key, this.goasl}) : super(key: key);

  @override
  _GoaldInformationPageState createState() => _GoaldInformationPageState();
}

class _GoaldInformationPageState extends State<GoaldInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _title(context),
          SizedBox(
            height: 20,
          ),
          _top10(),
          SizedBox(
            height: 20,
          ),
          _weightValue(),
        ],
      ),
    );
  }

  Widget _title(context) {
    return Text(
      '¡Esperamos que tengas excelentes ventas! A continuación te presentamos las metas del mes.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.white, fontSize: 17),
    );
  }

  Widget _top10() {
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Revisa el Top 10',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black, fontSize: 15.1),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                color: PromotoraApp().primaryDark,
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
        ),
        color: Colors.white,
        disabledTextColor: Colors.grey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TopTenPage()),
          );
        });
  }

  Widget _weightValue() {
    return Row(
      children: <Widget>[
        ClipRect(
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
            decoration: BoxDecoration(
              color: Colors.cyan[400],
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
                Text(
                  '' + widget.goasl.pdnCanc,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Cancelación',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 22,
        ),
        ClipRect(
          child: Container(
            padding: EdgeInsets.fromLTRB(13, 50, 13, 50),
            decoration: BoxDecoration(
                color: PromotoraApp().primaryDark,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                Text(
                  '' + widget.goasl.pdnTotal,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Producción total',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
