import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/questions_answer.dart';
import 'package:promotoraapp/Model/atac_model.dart';

class AtacPage extends StatefulWidget {
  final List<AtacModel> atac;

  AtacPage({Key key, this.atac}) : super(key: key);

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
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              _title(context),
              Expanded(
                child: _cardAtac(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(context) {
    return Text('Selecciona los temas en los cuales estas interasado');
  }

  Widget _cardAtac(context) {
    return _answer(context, widget.atac);
  }

  Widget _answer(context, List<AtacModel> faqlist) {
    print(faqlist);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: faqlist.length,
        itemBuilder: (context, index) {
          AtacModel document = faqlist[index];

          return ExpansionCard(
            questions: document.atacCategory,
            answer: '',
          );
        },
      ),
    );
  }
}
