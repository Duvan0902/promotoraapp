import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/categories_model.dart';
import 'package:mi_promotora/models/education_model.dart';
import 'package:mi_promotora/models/message_model.dart';
import 'package:mi_promotora/pages/education_detailed_page.dart';
import 'package:mi_promotora/pages/faq_page.dart';
import 'package:mi_promotora/pages/home_page.dart';
import 'package:mi_promotora/providers/education_provider.dart';
import 'package:mi_promotora/providers/faq_categories_provider.dart';
import 'package:mi_promotora/providers/push_notifications_provider.dart';

Future<void> manageNotifications(
    {GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    GlobalKey<NavigatorState> navigatorKey}) async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String token = await _firebaseMessaging.getToken();
  print('Device token: $token');

  final pushProvider = new PushNotificationsProvider();

  pushProvider.initNotifications();

  pushProvider.messageStreamm.listen(
    (message) {
      print('Message stream received: $message');
      scaffoldMessengerKey.currentState.removeCurrentSnackBar();

      scaffoldMessengerKey.currentState.showSnackBar(
        SnackBar(
          key: Key('notification'),
          backgroundColor: MiPromotora().accentLight,
          content: Text(message.notification.body),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'OK',
            textColor: MiPromotora().primary,
            disabledTextColor: MiPromotora().primary,
            onPressed: () {
              navigateToPage(message, navigatorKey);
            },
          ),
        ),
      );
    },
  );

  pushProvider.backgroundMessageStreamm.listen(
    (message) {
      print('Background message stream received: $message');
      navigateToPage(message, navigatorKey);
    },
  );
}

void navigateToPage(
    MessageModel message, GlobalKey<NavigatorState> navigatorKey) async {
  int argumentId = int.tryParse(message.data.tapActionArguments);
  Object arguments;
  String route;

  switch (message.data.tapAction) {
    case 'Metas':
      route = 'home';
      break;
    case 'Contactos':
      route = 'home';
      arguments = HomePageArguments(1, null);
      break;
    case 'Educación':
      EducationProvider educationProvider = EducationProvider();
      EducationModel education = await educationProvider
          .getById(int.tryParse(message.data.tapActionArguments));

      if (education != null) {
        navigatorKey.currentState.push(
          MaterialPageRoute(
            builder: (context) => EducationDetailedPage(complement: education),
          ),
        );
      }
      return;
      break;
    case 'Preguntas_frecuentes':
      FaqCategoriesProvider faqCategoriesProvider = FaqCategoriesProvider();
      FaqCategoriesModel faqCategory = await faqCategoriesProvider
          .getCategory(message.data.tapActionArguments);

      if (faqCategory != null) {
        navigatorKey.currentState.push(
          MaterialPageRoute(
            builder: (context) =>
                FaqPage(faqlist: faqCategory.faq, title: faqCategory.category),
          ),
        );
        return;
      }
      break;
    case 'Documentos':
      route = 'documents';
      break;
    case 'Chat':
      route = 'porchat';
      break;
    default:
      route = 'home';
  }

  print('Navigating to route $route with argumentId $argumentId');
  if (argumentId != null) {
    navigatorKey.currentState.pushNamed(route, arguments: arguments);
  } else {
    navigatorKey.currentState.pushNamed(route);
  }
}
