import 'package:flutter/material.dart';
import 'package:mi_promotora/pages/new_password_page.dart';
import '../main.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

String email = '';

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _background(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 70,
            ),
          ),
          Container(
            width: size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60),
                Container(
                  child: Text(
                    'Cambiar mi contraseña',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.black, fontSize: 35),
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Contraseña actual',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ),
                _passwordField(context),
                SizedBox(height: 30.0),
                SizedBox(height: 40.0),
                Container(
                  child: _nextPageButton(context),
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField(context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: TextField(
        obscureText: true,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MiPromotora().primaryDark),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MiPromotora().primaryDark),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: "Escribe tu contraseña",
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 14),
        ),
      ),
    );
  }
}

Widget _nextPageButton(context) {
  final size = MediaQuery.of(context).size;
  return RaisedButton(
    child: Container(
      width: size.width * 0.6,
      child: Text(
        'Siguiente',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(color: Colors.black, fontSize: 16),
      ),
    ),
    disabledColor: Colors.grey[300],
    color: MiPromotora().primaryDark,
    disabledTextColor: Colors.grey,
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewPasswordPage(),
      ),
    ),
  );
}

Widget _background(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: AssetImage("assets/img/fondo.png"),
        fit: BoxFit.fill,
      ),
    ),
  );
}
