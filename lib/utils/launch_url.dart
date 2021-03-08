import 'package:url_launcher/url_launcher.dart';

void callPhone(phone) async {
  if (await canLaunch('tel:' + phone)) {
    await launch('tel:' + phone);
  } else {
    throw 'Could not launch $phone';
  }
}
