import 'package:flutter/material.dart';
import 'package:mi_promotora/models/sales_model.dart';
import 'package:mi_promotora/pages/login_page.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/sales_provider.dart';
import 'home_page.dart';

class SalePage extends StatefulWidget {
  const SalePage({Key key}) : super(key: key);

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _date = '';
  String quantity = '';
  String clients = '';
  String idClient = '';
  String selectedSaleType;

  TextEditingController _dateController = TextEditingController();
  SalesProvider _salesProvider = SalesProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
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
        _saleType(),
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
        _values(context),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Cliente',
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
            'Nit/Cédula',
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

  Widget _saleType() {
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _salesProvider.getSalesCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<SalesCategoryModel>> snapshot) {
        List<SalesCategoryModel> saleTypes = snapshot.data;

        if (snapshot.hasData) {
          return Container(
            width: size.width * 0.9,
            color: Color.fromRGBO(243, 243, 243, 1),
            child: DropdownButton<String>(
              iconSize: 0.0,
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              items: saleTypes
                  .map(
                    (saleType) => DropdownMenuItem<String>(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          saleType.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black45, fontSize: 14),
                        ),
                      ),
                      value: saleType.id.toString(),
                    ),
                  )
                  .toList(),
              onChanged: (String value) {
                setState(() {
                  selectedSaleType = value;
                });
              },
              hint: Container(
                padding: EdgeInsets.all(10),
                child: Align(
                  child: Text(
                    'Escoge el tipo de venta',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black45, fontSize: 14),
                  ),
                ),
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black45, fontSize: 14),
              value: selectedSaleType,
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
            borderSide: BorderSide(color: MiPromotora().primaryDark),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: 'Selecciona la fecha',
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

  Widget _values(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black, fontSize: 14),
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MiPromotora().primaryDark),
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
        onChanged: (text) {
          setState(
            () {
              quantity = text;
            },
          );
        },
      ),
    );
  }

  Widget _client(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.multiline,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MiPromotora().primaryDark),
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
        onChanged: (text) {
          setState(
            () {
              clients = text;
            },
          );
        },
      ),
    );
  }

  Widget _nit(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black, fontSize: 14),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MiPromotora().primaryDark),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: 'Ingresa la identificación del cliente',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 14),
          errorStyle:
              Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        ),
        onChanged: (text) {
          setState(
            () {
              idClient = text;
            },
          );
        },
      ),
    );
  }

  Widget _registerButton(context) {
    final size = MediaQuery.of(context).size;
    bool isCompleted = selectedSaleType != null &&
        _date != "" &&
        quantity != "" &&
        clients != "" &&
        idClient != "";

    return ElevatedButton(
        child: Container(
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
        onPressed: isCompleted ? () => _sendInterests(context) : null);
  }

  _sendInterests(BuildContext context) async {
    final SalesProvider saleProvider = SalesProvider();
    final _prefs = new UserPreferences();
    final id = _prefs.userId;
    if (id == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
    SaleModel sale = await saleProvider.sendSale(
      selectedSaleType,
      _date,
      quantity,
      clients,
      idClient,
      id.toString(),
    );

    if (sale != null) {
      double points = double.tryParse(sale.value) / 1000;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Tu venta se envió correctamente con el ID ${sale.id.toString()}. Has ganado ${points.toInt()} puntos!",
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Aceptar',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: MiPromotora().primaryDark, fontSize: 16),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ),
                ),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Se ha producido un error al registrar tu venta, revisa que todos los campos hayan sido completados correctamente.',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Aceptar',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: MiPromotora().primaryDark, fontSize: 16),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
      );
    }
  }
}
