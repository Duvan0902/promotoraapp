import 'package:flutter/material.dart';
import 'package:MiPromotora/bloc/login_bloc.dart';
import 'package:MiPromotora/bloc/provider_bloc.dart';
import 'package:MiPromotora/main.dart';

class ChangePasswordPage extends StatelessWidget {
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
                SizedBox(height: 40.0),
                Container(
                  child: _createButton(bloc),
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

  Widget _mainTitle(context) {
    return Text(
      'Olvidé mi contraseña',
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

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final size = MediaQuery.of(context).size;
        return RaisedButton(
          child: Container(
            width: size.width * 0.6,
            child: Text(
              'Enviar enlace',
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
          onPressed: () {},
        );
      },
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
}
