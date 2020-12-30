import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/dropdownbutton.dart';
import 'package:promotoraapp/main.dart';

class SalePage extends StatefulWidget {
  const SalePage({Key key}) : super(key: key);

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _date = '';

  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[900],
          title: new Text(
            "Agregar una venta",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 20),
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 75),
            child: Icon(Icons.ac_unit),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              child: _posterTitle(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
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
        DropButton(),
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
        _dateSale(context),
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
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Nit/Cedula',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
        _nit(context),
        SizedBox(height: 40.0),
        _registerButton(context),
      ],
    );
  }

  Widget _dateSale(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black45, fontSize: 14),
        controller: _dateController,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.multiline,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PromotoraApp().primaryDark),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: 'selecciona la fecha',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 14),
          errorStyle:
              Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        ),
        onTap: () {
          _selectDate(context);
        },
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      setState(
        () {
          _date = picked.toString();
          _dateController.text = _date;
        },
      );
    }
  }

  Widget _value(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black45, fontSize: 14),
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PromotoraApp().primaryDark),
          ),
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
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PromotoraApp().primaryDark),
          ),
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

  Widget _nit(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PromotoraApp().primaryDark),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: 'ingresa identificación del cliente',
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
