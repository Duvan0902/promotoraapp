import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/providers/texts_provider.dart';

class TermsAndConditionsPage extends StatelessWidget {
  final UserPreferences prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[900],
        title: Text(
          "Términos y Condiciones",
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: TextsProvider().getTermsText(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                      controller: ScrollController(),
                      selectable: true,
                      data: snapshot.data,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            MiPromotora().accent),
                      ),
                      child: Text(
                        "Cancelar",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        prefs.acceptedTerms = false;
                        Navigator.of(context).pushNamed('login');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Aceptar",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        prefs.acceptedTerms = true;
                        if (prefs.acceptedPrivacyPolicy == true) {
                          Navigator.of(context).pushNamed('home');
                        } else {
                          Navigator.of(context).pushNamed('privacy-policy');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
