import 'package:flutter/material.dart';
import 'package:promotoraapp/models/goals_model.dart';
import 'package:promotoraapp/pages/sale_page.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/providers/goals_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyObjetivePage extends StatefulWidget {
  const MyObjetivePage({Key key}) : super(key: key);

  @override
  _MyObjetivePageState createState() => _MyObjetivePageState();
}

class _MyObjetivePageState extends State<MyObjetivePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[900],
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          _title(context),
          SizedBox(
            height: 30,
          ),
          Expanded(child: _progressIndicator(context)),
          SizedBox(
            height: 20,
          ),
          _addSaleButton(context),
        ],
      ),
    );
  }

  Widget _title(context) {
    return Text(
      'Registra cada una de las metas que realices en el mes, así podrás llevar el control de tus metas.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.white, fontSize: 17),
    );
  }

  Widget _progressIndicator(context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.pink, width: 3),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                margin: EdgeInsets.all(10),
                elevation: 1,
                child: Center(
                  child: Text(
                    '75%',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 28),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Números de ventas',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    'Cuantas llevo: 10',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black45, fontSize: 15),
                  ),
                  Text(
                    'Cuantas me faltan: 4',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black45, fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Expanded(child: _downloadButton(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _downloadButton(context) {
    final servicesProvider = GoalsProvider();
    return Container(
      width: 150,
      child: FutureBuilder(
        future: servicesProvider.getGoals(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _contactsList(snapshot.data);
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

  Widget _contactsList(List<GoalsModel> goals) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          return FlatButton(
            textColor: PromotoraApp().primaryDark,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(2),
            onPressed: () => _launchURL(goals[index].integratedReport.file.url),
            child: Text(
              "Descargar reporte",
              style: TextStyle(fontSize: 17.0),
            ),
          );
        },
      ),
    );
  }

  Widget _addSaleButton(context) {
    final size = MediaQuery.of(context).size;
    return RaisedButton(
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.04,
        child: Text(
          'Agregar mi venta',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.black, fontSize: 17),
        ),
      ),
      color: PromotoraApp().primaryDark,
      disabledTextColor: Colors.grey,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalePage(),
          ),
        );
      },
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
