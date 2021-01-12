import 'package:flutter/material.dart';
import 'package:promotoraapp/Page/sale_page.dart';
import 'package:promotoraapp/main.dart';

class MyObjetivePage extends StatelessWidget {
  const MyObjetivePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[900],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            _title(context),
            SizedBox(
              height: 30,
            ),
            _progressIndicator(context),
            SizedBox(
              height: 20,
            ),
            _addSaleButton(context),
          ],
        ),
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
        padding: EdgeInsets.all(20),
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
              width: 10,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                FlatButton(
                  textColor: PromotoraApp().primaryDark,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(2),
                  onPressed: () {},
                  child: Text(
                    "Descargar reporte",
                    style: TextStyle(fontSize: 17.0),
                  ),
                )
              ],
            )
          ],
        ),
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
