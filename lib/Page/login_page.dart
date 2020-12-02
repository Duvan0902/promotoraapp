import 'package:flutter/material.dart';
import 'package:promotoraapp/bloc/login_bloc.dart';
import 'package:promotoraapp/bloc/provider_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                SizedBox(height: 30),
                Container(
                  child: _mainTitle(context),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 40),
                Text(
                  'Correo electrónico',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black),
                ),
                _emailField(bloc),
                SizedBox(height: 30.0),
                Text(
                  'Código',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black),
                ),
                _passwordField(bloc),
                SizedBox(height: 30.0),
                Container(
                  child: _createButton(bloc),
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(height: 50),
                Text(
                  'Olvidé mi contraseña',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.lightBlueAccent),
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
      'Inicio de sesión de Promotora',
      textAlign: TextAlign.left,
      style:
          Theme.of(context).textTheme.headline1.copyWith(color: Colors.black),
    );
  }

  Widget _emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Escribe tu correo electrónico',
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
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Escribe tu contraseña",
            errorText: snapshot.error,
            errorStyle: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.red),
          ),
          onChanged: bloc.changePassword,
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
              width: size.width * 0.5,
              child: Text(
                'Inicio de sesión',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.black),
              ),
            ),
            color: Colors.lightBlueAccent,
            disabledTextColor: Colors.grey,
            onPressed: () {});
      },
    );
  }
}
