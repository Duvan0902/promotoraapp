import 'package:flutter/material.dart';
import 'package:mi_promotora/pages/home_page.dart';
import 'package:mi_promotora/pages/login_page.dart';
import 'package:mi_promotora/pages/sale_page.dart';
import 'package:mi_promotora/bloc/provider_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromPath("assets/config/settings.json");
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(MiPromotora());
}

class MiPromotora extends StatelessWidget {
  final prefs = new UserPreferences();
  Color get accent => Color(0xffe7326e);
  Color get accentLight => Color(0xffff6c9c);
  Color get accentDark => Color(0xffaf0043);
  Color get primary => Color(0xff0074ca);
  Color get primaryLight => Color(0xff5ba2fe);
  Color get primaryDark => Color.fromRGBO(0, 186, 193, 3);
  Color get grey => Colors.grey[900];

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Promotora App',
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English, no country code
          const Locale('es', 'ES'), // Spanish, no country code
        ],
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Asap',
          primaryColor: primary,
          primaryColorLight: primaryLight,
          primaryColorDark: primaryDark,
          accentColor: accent,
          colorScheme:
              ColorScheme.light(primary: primaryDark, secondary: accent),
          buttonTheme: ButtonThemeData(
            buttonColor: accent,
            disabledColor: accentLight,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 30.0,
                fontFamily: 'AsapBold',
                color: Colors.black,
                fontWeight: FontWeight.bold),
            headline2: TextStyle(
              fontSize: 20.0,
              fontFamily: 'AsapMedium',
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: 20.0,
              fontFamily: 'AsapBoldltalic',
              color: Colors.black,
            ),
            headline4: TextStyle(
              fontSize: 18.0,
              fontFamily: ' AsapItalic',
            ),
            headline5: TextStyle(
              fontSize: 14.0,
              fontFamily: ' AsapMediumItalic',
            ),
            bodyText1: TextStyle(
              fontFamily: 'AsapRegular',
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              fontSize: 16.0,
              fontFamily: 'AsapMedium',
            ),
            subtitle1: TextStyle(
              fontSize: 18.0,
              fontFamily: 'AsapSemiBoldItalic',
              color: Colors.black26,
            ),
            subtitle2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'AsapRegular',
            ),
            caption: TextStyle(
              fontSize: 25.0,
              fontFamily: 'AsapMedium',
              color: Colors.white,
            ),
            button: TextStyle(
              fontSize: 10.0,
              fontFamily: 'AsapBold',
            ),
          ),
        ),
        initialRoute: prefs.token != null ? 'home' : 'login',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'login': (BuildContext context) => LoginPage(),
          'sale': (BuildContext context) => SalePage(),
        },
      ),
    );
  }
}
