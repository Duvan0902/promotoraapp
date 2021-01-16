import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:promotoraapp/common/raised_Button.dart';
import 'package:flutter/foundation.dart';
import 'package:promotoraapp/main.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: const Radius.circular(80.0),
      ),
      child: Drawer(
        child: Container(
          color: PromotoraApp().primaryDark,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 20, 20, 30),
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                'Tu sesión en Promotora',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.black, fontSize: 33),
              ),
              SizedBox(height: 40),
              BottomList(
                title: 'Mis metas',
                icon: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  iconSize: 28,
                  onPressed: () {},
                ),
                route: 'sale',
              ),
              SizedBox(height: 18),
              BottomList(
                title: 'Preguntas Frecuentes',
                icon: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  iconSize: 28,
                  onPressed: () {},
                ),
                route: 'questions',
              ),
              SizedBox(height: 18),
              BottomList(
                title: 'Documentos para tu gestion',
                icon: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  iconSize: 28,
                  onPressed: () {},
                ),
                route: 'Documents',
              ),
              SizedBox(height: 18),
              BottomList(
                title: 'Chat',
                icon: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  iconSize: 28,
                  onPressed: () {},
                ),
                route: 'sale',
              ),
              SizedBox(height: 200),
              BottomList(
                title: 'Cerrar sesión',
                icon: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  iconSize: 28,
                  onPressed: () {},
                ),
                route: 'sale',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
