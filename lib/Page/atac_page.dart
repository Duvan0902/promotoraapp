import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:promotoraapp/Model/atac_model.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/utils/alert_dialog.dart';
import 'package:promotoraapp/provider/atac_requests_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtacPage extends StatefulWidget {
  final List<AtacCategory> atac;
  final Function() onChanged;
  final bool highlight;

  const AtacPage({
    Key key,
    this.atac,
    this.highlight,
    this.onChanged,
  })  : assert(atac != null),
        super(key: key);

  @override
  AtacPageState createState() => AtacPageState();
}

class AtacPageState extends State<AtacPage> {
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
                child: _cardAtac(context, widget.atac),
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
      'Selecciona los temas en los cuales estas interasado',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.black, fontSize: 17),
    );
  }

  Widget _cardAtac(context, List<AtacCategory> atac) {
    bool _expanded = false;
    Color iconColor = PromotoraApp().primaryDark;
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
                  _subCategory(document.atacSubcategories),
                  SizedBox(height: 5),
                ],
                onExpansionChanged: (changed) {
                  setState(() {
                    _expanded = changed;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged.call();
                  }
                },
                initiallyExpanded: _expanded,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _subCategory(List<AtacSubcategory> subcategories) {
    Map<String, bool> values = Map.fromIterable(subcategories,
        key: (e) => e.atacSubcategory, value: (e) => false);
    var holder_1 = [];

    items() {
      values.forEach((key, value) {
        if (value == true) {
          holder_1.add(key);
        }
      });

      // Printing all selected items on Terminal screen.
      print(holder_1);
      // Here you will get all your selected Checkbox items.

      // Clear array after use.
      holder_1.clear();
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
                  activeColor: PromotoraApp().primaryDark,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
            RaisedButton(
              child: Text(
                " Get Checked Checkbox Items ",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: items,
              color: Colors.green,
              textColor: Colors.white,
              splashColor: Colors.grey,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PromotoraApp().primaryDark),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black45, fontSize: 14),
                  ),
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
        color: PromotoraApp().primaryDark,
        disabledTextColor: Colors.grey,
        onPressed: () => _sendInterests(context));
  }
}

_sendInterests(BuildContext context) async {
  final AtacRequestsProvider requestsProvider = AtacRequestsProvider();
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getInt('id') ?? 13;

  bool sent = await requestsProvider.sendInterests(
      id.toString(), 'Talento Humano', 'No tengo opinión');
  if (sent) {
    showAlert(context, 'Su respuesta se envio correctamente');
  }
}
