import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';

class SaleList extends StatelessWidget {
  const SaleList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Tipo de venta',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
        _sale(context),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Fecha',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
        _date(context),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Valor de la venta',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
        _value(context),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'cliente',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
        _client(context),
        SizedBox(height: 40.0),
        _registerButton(context),
      ],
    );
  }

  Widget _sale(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Escoge el tipo de venta',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 14),
          errorStyle:
              Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  Widget _date(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'selecciona la fecha',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 14),
          errorStyle:
              Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  Widget _value(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Ingresa el valor',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 14),
          errorStyle:
              Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  Widget _client(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Escribe el nombre',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 14),
          errorStyle:
              Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  Widget _registerButton(context) {
    final size = MediaQuery.of(context).size;
    return RaisedButton(
        child: Container(
          decoration: BoxDecoration(),
          height: size.height * 0.04,
          width: size.width * 0.7,
          child: Text(
            'Registra la venta',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
        color: PromotoraApp().primaryDark,
        disabledTextColor: Colors.grey,
        onPressed: () {});
  }
}
