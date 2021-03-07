import 'package:flutter/material.dart';
import 'package:mi_promotora/bloc/login_bloc.dart';
import 'package:mi_promotora/bloc/provider_bloc.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/providers/login_provider.dart';
import 'package:mi_promotora/utils/alert_dialog.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

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
    final bloc = Provider.of(context);
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
                  child: _mainTitle(context),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Correo electrónico',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ),
                _emailField(bloc),
                SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Contraseña',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ),
                _passwordField(bloc),
                SizedBox(height: 40.0),
                Container(
                  child: _createButton(bloc),
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(height: 25),
                Container(
                  child: _forgotPassword(context),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainTitle(context) {
    return Text(
      'Inicia sesión en Promotora',
      textAlign: TextAlign.left,
      style: Theme.of(context)
          .textTheme
          .headline1
          .copyWith(color: Colors.black, fontSize: 35),
    );
  }

  Widget _emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          color: Color.fromRGBO(243, 243, 243, 1),
          child: TextField(
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
              hintText: 'Escribe tu correo electrónico',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black45, fontSize: 14),
              errorText: snapshot.error,
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.red),
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          color: Color.fromRGBO(243, 243, 243, 1),
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.cyan),
            child: TextField(
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black, fontSize: 18),
              obscureText: _isPasswordHidden,
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
                errorText: snapshot.error,
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.red),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: _toggleVisibility,
                ),
              ),
              onChanged: bloc.changePassword,
            ),
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final size = MediaQuery.of(context).size;
        return RaisedButton(
          child: Container(
            width: size.width * 0.6,
            child: Text(
              'Inicia sesión',
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
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }
}

Widget _forgotPassword(context) {
  return FlatButton(
    textColor: MiPromotora().primaryDark,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordPage(),
        ),
      );
    },
    child: Text(
      "Olvidé mi contraseña",
      style: Theme.of(context)
          .textTheme
          .headline1
          .copyWith(color: MiPromotora().primaryDark, fontSize: 18),
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

_login(LoginBloc bloc, BuildContext context) async {
  final LoginProvider loginProvider = LoginProvider();
  Map info = await loginProvider.login(bloc.identity, bloc.password);
  if (info['ok']) {
    Navigator.pushReplacementNamed(context, 'home');
  } else {
    showAlert(context, info['message']);
  }
}
