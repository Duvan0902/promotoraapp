import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/bloc/provider_bloc.dart';
import 'package:mi_promotora/common/custom_web_view.dart';
import 'package:mi_promotora/pages/change_password_page.dart';
import 'package:mi_promotora/pages/documents_page.dart';
import 'package:mi_promotora/pages/faq_categories_page.dart';
import 'package:mi_promotora/pages/home_page.dart';
import 'package:mi_promotora/pages/login_page.dart';
import 'package:mi_promotora/pages/privacy_policy.dart';
import 'package:mi_promotora/pages/sale_page.dart';
import 'package:mi_promotora/pages/sales_categories_page.dart';
import 'package:mi_promotora/pages/terms_and_conditions.dart';
import 'package:mi_promotora/preferences/users_preferences.dart';
import 'package:mi_promotora/utils/manage_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromPath("assets/config/settings.json");
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(MiPromotora());
}

class MiPromotora extends StatefulWidget {
  final prefs = new UserPreferences();

  Color get accent => Color(0xffe7326e);
  Color get accentLight => Color(0xffff6c9c);
  Color get accentDark => Color(0xffaf0043);
  Color get primary => Color(0xff0074ca);
  Color get primaryLight => Color(0xff5ba2fe);
  Color get primaryDark => Color.fromRGBO(0, 186, 193, 3);
  Color get grey => Colors.grey[900];
  Color get greyLight => Colors.grey[300];

  @override
  _MiPromotoraState createState() => _MiPromotoraState();
}

class _MiPromotoraState extends State<MiPromotora> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    manageNotifications(
        scaffoldMessengerKey: scaffoldMessengerKey, navigatorKey: navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Mi Promotora',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es', 'CO'),
          const Locale('es', 'ES'),
          const Locale('es', 'US'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Asap',
          primaryColor: widget.primary,
          primaryColorLight: widget.primaryLight,
          primaryColorDark: widget.primaryDark,
          accentColor: widget.accent,
          colorScheme: ColorScheme.light(
              primary: widget.primaryDark, secondary: widget.accent),
          buttonTheme: ButtonThemeData(
            buttonColor: widget.accent,
            disabledColor: widget.accentLight,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return widget.greyLight;
                return null; // Defer to the widget's default.
              }),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) return widget.grey;
                return null; // Defer to the widget's default.
              }),
            ),
          ),
          dividerColor: Colors.transparent,
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
        initialRoute: _initialRoute(),
        routes: {
          'home': (BuildContext context) => HomePage(),
          'login': (BuildContext context) => LoginPage(),
          'sale': (BuildContext context) => SalePage(),
          'faq': (BuildContext context) => FaqCategoriesPage(),
          'documents': (BuildContext context) => DocumentsPage(),
          'porchat': (BuildContext context) => CustomWebView(),
          'change-pass': (BuildContext context) => ChangePasswordPage(),
          'privacy-policy': (BuildContext context) => PrivacyPolicyPage(),
          'terms-and-conditions': (BuildContext context) =>
              TermsAndConditionsPage(),
          'sales-categories': (BuildContext context) => SalesCategoriesPage()
        },
      ),
    );
  }

  String _initialRoute() {
    if (widget.prefs.token != null) {
      if (widget.prefs.acceptedTerms == true) {
        if (widget.prefs.acceptedPrivacyPolicy == true)
          return 'home';
        else
          return 'privacy-policy';
      } else {
        return 'terms-and-conditions';
      }
    } else {
      return 'login';
    }
  }
}
