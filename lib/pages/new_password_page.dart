import 'package:flutter/material.dart';
import 'package:mi_promotora/bloc/password_update_bloc.dart';
import 'package:mi_promotora/bloc/provider_bloc.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/user_model.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/users_provider.dart';
import 'package:mi_promotora/utils/alert_dialog.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
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
    final PasswordUpdateBloc passwordUpdateBloc =
        Provider.passwordUpdate(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 40,
            ),
          ),
          Container(
            width: size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  child: Text(
                    'Nueva contraseña',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.black, fontSize: 35),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Nueva contraseña',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ),
                _passwordField(passwordUpdateBloc),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Repite tu contraseña',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ),
                _repeatPassword(passwordUpdateBloc),
                SizedBox(height: 40.0),
                Container(
                  child: recommendationList(context),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 40.0),
                Container(
                  child: _createButton(passwordUpdateBloc, context),
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

  Widget _passwordField(PasswordUpdateBloc bloc) {
    return StreamBuilder(
      stream: bloc.newPasswordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              errorText: snapshot.error,
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.red),
            ),
            onChanged: bloc.changeNewPassword(),
          ),
        );
      },
    );
  }

  Widget _repeatPassword(PasswordUpdateBloc bloc) {
    return StreamBuilder(
      stream: bloc.newPasswordCheckStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          color: Color.fromRGBO(243, 243, 243, 1),
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.cyan),
            child: TextField(
              obscureText: _isPasswordHidden,
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
                errorText: snapshot.error,
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.red),
                suffixIcon: IconButton(
                    icon: Icon(_isPasswordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: _toggleVisibility),
              ),
              onChanged: bloc.changeNewPasswordConfirmation(),
            ),
          ),
        );
      },
    );
  }

  Widget _createButton(PasswordUpdateBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.checkNewPasswordsStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final size = MediaQuery.of(context).size;
        return RaisedButton(
          child: Container(
            width: size.width * 0.6,
            child: Text(
              'Actualizar contraseña',
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
          onPressed:
              snapshot.hasData ? () => _updatePassword(bloc, context) : null,
        );
      },
    );
  }

  _updatePassword(PasswordUpdateBloc bloc, BuildContext context) async {
    final prefs = UserPreferences();
    final userProvider = UsersProvider();
    UserModel currentUser = await userProvider.getUser(prefs.userId);

    if (await userProvider.updateUserPass(currentUser, bloc.newPassword)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Contraseña actualizada satisfactoriamente",
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Aceptar',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: MiPromotora().primaryDark, fontSize: 16),
                ),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'home'),
              )
            ],
          );
        },
      );
    } else {
      showAlert(context,
          "Hubo un error inesperado, la contraseña no pudo ser actualizada");
    }
  }

  Widget recommendationList(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Mínimo 8 caracteres',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black45, fontSize: 15),
          ),
          SizedBox(height: 5),
          Text(
            'Utiliza letras y numeros',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black45, fontSize: 15),
          ),
          SizedBox(height: 5),
          Text(
            'Utiliza caracteres especiales (como @,?,%)',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black45, fontSize: 15),
          ),
          SizedBox(height: 5),
          Text(
            'Combina letras mayusculas y minusculas',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black45, fontSize: 15),
          ),
        ],
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
}
