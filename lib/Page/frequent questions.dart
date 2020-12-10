import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/bottom_chat.dart';
import 'package:promotoraapp/Common/raised_Button.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key key}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30,
                onPressed: () {},
              ),
              Text(
                "Preguntas Frecuentes",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.grey,
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(25.0),
                child: _posterTitle(context),
              ),
              SizedBox(height: 55),
              _chat(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          BottomList(
            title: 'Salud',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              iconSize: 28,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BottomList(
            title: 'Vida',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              iconSize: 28,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BottomList(
            title: 'Asistente Virtual',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              iconSize: 28,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BottomList(
            title: 'Firma cliente',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              iconSize: 28,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BottomList(
            title: 'Cambio de intermedio',
            route: 'sale',
            icon: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _chat(context) {
    return BottomChat();
  }
}
