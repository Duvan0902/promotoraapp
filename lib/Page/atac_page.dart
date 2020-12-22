import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/questions_answer.dart';
import 'package:promotoraapp/Model/atac_model.dart';
import 'package:promotoraapp/main.dart';

class AtacPage extends StatefulWidget {
  final List<AtacModel> atac;

  AtacPage({
    Key key,
    this.atac,
  }) : super(key: key);

  @override
  _AtacPageState createState() => _AtacPageState();
}

class _AtacPageState extends State<AtacPage> {
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
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _title(context),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: _cardAtac(context),
              ),
              _others(),
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

  Widget _cardAtac(context) {
    return _answer(context, widget.atac);
  }

  Widget _answer(context, List<AtacModel> faqlist) {
    print(faqlist);
    return Container(
      child: ListView.builder(
        itemCount: faqlist.length,
        itemBuilder: (context, index) {
          AtacModel document = faqlist[index];

          return ExpansionCard(
            questions: document.atacCategory,
            answer: document.atacCategory,
          );
        },
      ),
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
}
