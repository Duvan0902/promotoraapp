import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/message_model.dart';
import 'package:mi_promotora/pages/home_page.dart';
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
    MessageModel message, GlobalKey<NavigatorState> navigatorKey) {
  int argumentId = int.tryParse(message.data.tapActionArguments);
  Object arguments;
  String route;

  switch (message.data.tapAction) {
    case 'Metas':
      route = 'home';
      break;
    case 'Contactos':
      route = 'home';
      break;
    case 'Educación':
      route = 'home';
      arguments = HomePageArguments(3, argumentId);
      break;
    case 'Preguntas_frecuentes':
      route = 'faq';
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
