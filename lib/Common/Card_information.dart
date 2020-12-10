import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/raised_Button.dart';
import 'package:promotoraapp/main.dart';

class GeneralCard extends StatelessWidget {
  const GeneralCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(20, 30, 40, 80),
            title: Text('Titulo'),
            subtitle: Text(
                'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
          ),
        ),
        SizedBox(height: 10),
        BottomList(
          title: 'contacto',
          route: 'sale',
          icon: IconButton(
            icon: Icon(Icons.call_outlined),
            iconSize: 36,
            onPressed: () {},
          ),
        ),
        SizedBox(height: 10),
        BottomList(
          title: 'contacto',
          route: 'sale',
          icon: IconButton(
            icon: Icon(Icons.call_outlined),
            iconSize: 36,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
