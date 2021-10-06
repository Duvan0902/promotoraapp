import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/sales_model.dart';
import 'package:mi_promotora/pages/sales_list_page.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/sales_provider.dart';
import 'package:mi_promotora/utils/random_color.dart';

class SalesCategoriesPage extends StatefulWidget {
  SalesCategoriesPage({Key key}) : super(key: key);

  @override
  _SalesCategoriesPageState createState() => _SalesCategoriesPageState();
}

class _SalesCategoriesPageState extends State<SalesCategoriesPage> {
  final String _url = GlobalConfiguration().getValue("api_url");

  final salesProvider = SalesProvider();

  final _prefs = UserPreferences();

  TextEditingController _dateController = TextEditingController();
  String _date;

  @override
  void initState() {
    super.initState();
    setState(() {
      DateFormat formatter = DateFormat('yyyy-MM-01');
      _date = formatter.format(DateTime.now());
      _dateController.text = _date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[900],
        title: new Text(
          "Mis ventas",
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          padding: EdgeInsets.only(left: 75),
          child: Icon(Icons.ac_unit),
        ),
      ),
      body: Container(
        color: Colors.grey[900],
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Aquí encontrarás el resumen de tus ventas del mes.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontSize: 17),
              ),
            ),
            _dateSale(context),
            _totalSales(context),
            _categories(context),
          ],
        ),
      ),
    );
  }

  Widget _dateSale(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(243, 243, 243, 1),
      ),
      margin: EdgeInsets.all(10),
      //color: Color.fromRGBO(243, 243, 243, 1),
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
              .copyWith(color: MiPromotora().grey, fontSize: 14),
          errorStyle:
              Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red),
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
      var formatter = new DateFormat('yyyy-MM-dd');

      setState(
        () {
          _date = formatter.format(picked);
          _dateController.text = _date;
        },
      );
    }
  }

  Widget _categories(context) {
    return FutureBuilder(
      future: salesProvider.getSalesCategories(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _categoriesList(context, snapshot.data);
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _categoriesList(
      BuildContext context, List<SalesCategoryModel> salesCategories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: salesCategories.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return _category(context, salesCategories[index]);
      },
    );
  }

  Widget _category(BuildContext context, SalesCategoryModel category) {
    return InkWell(
      child: ClipRect(
        child: Container(
          height: 150.0,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: generateRandomColor(),
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
                child: category.icon != null
                    ? Image.network(
                        _url + category.icon.url,
                        color: Colors.black,
                        width: 30,
                        height: 30,
                        scale: 1,
                      )
                    : SizedBox.shrink(),
              ),
              Text(
                category.title,
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
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SalesListPage(category: category, date: _date),
          ),
        );
      },
    );
  }

  Widget _totalSales(context) {
    return FutureBuilder(
      future: salesProvider.getSalesByUser(null, _prefs.userId, _date),
      builder: (BuildContext context, AsyncSnapshot<List<SaleModel>> snapshot) {
        if (snapshot.hasData) {
          List<SaleModel> sales = snapshot.data;

          double total = sales
              .map((e) => double.tryParse(e.value))
              .reduce((a, b) => a + b);

          final NumberFormat currencyFormat = NumberFormat.currency(
              locale: 'es_CO',
              symbol: '\$',
              decimalDigits: 0,
              customPattern: '\u00A4###,###');
          String formattedTotal = currencyFormat.format(total);

          print(formattedTotal);

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: MiPromotora().accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    formattedTotal,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
