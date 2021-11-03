import 'package:url_launcher/url_launcher.dart';

void callPhone(phone) async {
  if (await canLaunch('tel:' + phone)) {
    await launch('tel:' + phone);
  } else {
    throw 'Could not launch $phone';
  }
}

void launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}
