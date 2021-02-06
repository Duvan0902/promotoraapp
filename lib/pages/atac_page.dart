import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mi_promotora/models/atac_model.dart';
import 'package:mi_promotora/pages/login_page.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/atac_requests_provider.dart';

import 'home_page.dart';

class AtacPage extends StatefulWidget {
  final List<AtacCategory> categoriesAtac;

  final AtacModel atac;

  const AtacPage({
    Key key,
    this.categoriesAtac,
    this.atac,
  })  : assert(categoriesAtac != null),
        super(key: key);

  @override
  AtacPageState createState() => AtacPageState();
}

class AtacPageState extends State<AtacPage> {
  List<String> interests = [];
  String data = "";
  String others = 'Otros: ';

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
            "ATAC",
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
        ),
        body: Container(
          padding: EdgeInsets.all(17),
          child: Column(
            children: <Widget>[
              _title(context),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: _cardAtac(context, widget.categoriesAtac),
              ),
              _others(),
              SizedBox(
                height: 10,
              ),
              _sendButton(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(context) {
    return Text(
      'Selecciona los temas en los cuales estas interesado.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.black, fontSize: 17),
    );
  }

  Widget _cardAtac(context, List<AtacCategory> atac) {
    bool _expanded = false;
    Color iconColor = MiPromotora().primaryDark;
    return Container(
      child: ListView.builder(
        itemCount: atac.length,
        itemBuilder: (context, index) {
          AtacCategory document = atac[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ExpansionTile(
                trailing: _expanded
                    ? Icon(
                        Icons.remove_circle_outline,
                        color: iconColor,
                      )
                    : Icon(
                        Icons.add_circle_outline,
                        color: iconColor,
                      ),
                title: document.atacCategory != null
                    ? Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          document.atacCategory,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black, fontSize: 16),
                        ),
                      )
                    : false,
                children: [
                  _subCategory(
                      document.atacSubcategories, document.atacCategory),
                  SizedBox(height: 5),
                ],
                onExpansionChanged: (changed) {
                  setState(() {
                    _expanded = changed;
                  });
                },
                initiallyExpanded: _expanded,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _subCategory(List<AtacSubcategory> subcategories, atac) {
    Map<String, bool> values = Map.fromIterable(subcategories,
        key: (e) => e.atacSubcategory, value: (e) => false);

    items() {
      values.forEach(
        (key, value) {
          if (value == true) {
            interests.add(
              (key) + ('-' + atac),
            );
          } else {
            interests.remove((key) + ('-' + atac));
          }
        },
      );

      print(interests);
    }

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            Column(
              children: values.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(
                    key,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                  value: values[key],
                  activeColor: MiPromotora().primaryDark,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(
                      () {
                        values[key] = (value);
                        if (value) {
                          items();
                        }
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _others() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          child: Row(
            children: <Widget>[
              Text('Otros:'),
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.multiline,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MiPromotora().primaryDark),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black45, fontSize: 14),
                  ),
                  onChanged: (text) {
                    setState(
                      () {
                        data = text;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sendButton() {
    final size = MediaQuery.of(context).size;

    return RaisedButton(
        child: Container(
          width: size.width * 0.7,
          child: Text(
            'Enviar',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: Colors.black, fontSize: 19),
          ),
        ),
        disabledColor: Colors.grey[300],
        color: MiPromotora().primaryDark,
        disabledTextColor: Colors.grey,
        onPressed: () =>
            interests.isEmpty ? _alert() : _sendInterests(context));
  }

  _alert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Su respuesta es vacia vuelva a intentarlo',
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
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

  _sendInterests(BuildContext context) async {
    final AtacRequestsProvider requestsProvider = AtacRequestsProvider();
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

    bool sent = await requestsProvider.sendInterests(
      id.toString(),
      widget.atac.name,
      (interests.toSet().toString() + ('-Otros: $data')),
    );

    if (sent) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Su respuesta  se envio correctamente',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK',
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
    }
  }
}
