import 'package:mi_promotora/pages/change_password_page.dart';
import 'package:mi_promotora/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:mi_promotora/common/raised_Button.dart';
import 'package:mi_promotora/pages/login_page.dart';
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
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 8, 15),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Mis metas',
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
                    color: Colors.white,
                    disabledTextColor: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Preguntas Frecuentes',
                    route: 'questions',
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Documentos para tu gestion',
                    route: 'Documents',
                  ),
                  SizedBox(height: 18),
                  BottomList(
                    title: 'Chat',
                    route: 'Porchat',
                  ),
                  SizedBox(height: 18),
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 8, 15),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cambiar mi contraseña',
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
                    color: Colors.white,
                    disabledTextColor: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 200),
                  RaisedButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 8, 15),
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
                                  .copyWith(
                                      color: Colors.black, fontSize: 15.1),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: MiPromotora().primaryDark,
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                      disabledTextColor: Colors.grey,
                      onPressed: () => prefs.token != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
