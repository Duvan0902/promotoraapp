import 'package:flutter/material.dart';
import 'package:promotoraapp/Model/login_model.dart';
import 'package:promotoraapp/bloc/login_bloc.dart';
import 'package:promotoraapp/bloc/provider_bloc.dart';
import 'package:promotoraapp/main.dart';
import 'package:promotoraapp/provider/login_provider.dart';
import 'package:promotoraapp/utils/alert_dialog.dart';

class LoginPage extends StatelessWidget {
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
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: 'Escribe tu correo electrónico',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black45, fontSize: 14),
              errorText: snapshot.error,
              errorStyle: Theme.of(context)
                  .textTheme
                  .headline4
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
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
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
            ),
            onChanged: bloc.changePassword,
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
          color: PromotoraApp().primaryDark,
          disabledTextColor: Colors.grey,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }
}

Widget _forgotPassword(context) {
  return Text(
    'Olvidé mi contraceña',
    textAlign: TextAlign.center,
    style: Theme.of(context).textTheme.headline1.copyWith(
          color: PromotoraApp().primaryDark,
          fontSize: 16,
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
  loginProvider.login(bloc.identifier, bloc.password);
}
