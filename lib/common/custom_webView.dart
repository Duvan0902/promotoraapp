import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:global_configuration/global_configuration.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String url = GlobalConfiguration().getValue("chat_url");

    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[900],
          title: new Text(
            "Portchat",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 20),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(context)),
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 75),
            child: Icon(Icons.ac_unit),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (!request.url.startsWith(url)) {
                print('Blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('Allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          ),
        ),
      ),
    );
  }
}
