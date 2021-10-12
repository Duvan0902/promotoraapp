import 'package:flutter/material.dart';
import 'package:mi_promotora/bloc/login_bloc.dart';
import 'package:mi_promotora/bloc/provider_bloc.dart';
import 'package:mi_promotora/pages/new_password_page.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/login_provider.dart';
import 'package:mi_promotora/utils/alert_dialog.dart';
import '../main.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

String email = '';

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _isPasswordHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: MiPromotora().accent),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
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
    final bloc = Provider.of(context);

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
                _passwordField(context, bloc),
                SizedBox(height: 30.0),
                SizedBox(height: 40.0),
                Container(
                  child: _nextPageButton(context, bloc),
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

  Widget _passwordField(BuildContext context, LoginBloc bloc) {
    final _prefs = UserPreferences();

    return StreamBuilder(
      stream: bloc.passwordStream,
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
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: _toggleVisibility,
                ),
              ),
              onChanged: (value) {
                bloc.changePassword(value);
                bloc.changeEmail(_prefs.userEmail);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _nextPageButton(BuildContext context, LoginBloc bloc) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          child: Container(
            width: size.width * 0.6,
            child: Text(
              'Siguiente',
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
            ),
          ),
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  Widget _background(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        color: Colors.transparent,
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPasswordPage(),
        ),
      );
    } else {
      showAlert(context, info['message']);
    }
  }
}
