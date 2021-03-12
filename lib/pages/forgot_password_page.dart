import 'package:flutter/material.dart';
import 'package:mi_promotora/providers/forgot_password_provider.dart';
import '../main.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

String email = '';

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                _emailField(context),
                SizedBox(height: 30.0),
                SizedBox(height: 40.0),
                Container(
                  child: _createButton(context),
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

  Widget _emailField(context) {
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
          //errorText: 'correo invalido',
          errorStyle:
              Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        onChanged: (text) {
          setState(
            () {
              email = text;
            },
          );
        },
      ),
    );
  }
}

Widget _createButton(context) {
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
      onPressed: () => _sendInterests(context));
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

_sendInterests(BuildContext context) async {
  final ForgotPasswordProvider saleProvider = ForgotPasswordProvider();

  bool sent = await saleProvider.sendPassword(email);
  print(email);
  if (sent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Su correo se envio correctamente',
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: MiPromotora().primaryDark, fontSize: 16),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
              ),
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Este correo electronico no existe, vualva a intentarlo.',
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'OK',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: MiPromotora().primaryDark, fontSize: 16),
                ),
                onPressed: () => Navigator.pop(context))
          ],
        );
      },
    );
  }
}
