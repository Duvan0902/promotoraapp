import 'package:flutter/material.dart';
import 'package:mi_promotora/common/raised_button.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';

import '../main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(80.0),
        ),
        child: Drawer(
          child: Container(
            color: MiPromotora().primaryDark,
            padding: const EdgeInsets.fromLTRB(12, 20, 20, 30),
            child: SingleChildScrollView(
              child: Column(
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
                    route: 'home',
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Mis ventas',
                    route: 'sales-categories',
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Mis clientes',
                    route: 'customers',
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Preguntas Frecuentes',
                    route: 'faq',
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Documentos para tu gestion',
                    route: 'documents',
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Chat',
                    route: 'porchat',
                  ),
                  SizedBox(height: 18),
                  ElevatedButton(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cerrar sesión',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(color: Colors.black, fontSize: 15.1),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: MiPromotora().primaryDark,
                          ),
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(20, 15, 8, 15)),
                    ),
                    onPressed: () {
                      prefs.token = null;
                      prefs.userEmail = null;
                      prefs.userId = null;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'login', (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
