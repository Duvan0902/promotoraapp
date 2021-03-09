import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_web_view.dart';

class BottomChat extends StatelessWidget {
  const BottomChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 35),
        child: FloatingActionButton(
          backgroundColor: Colors.pink[400],
          elevation: 5.0,
          child: Icon(
            CupertinoIcons.chat_bubble_text,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomWebView()),
            );
          },
        ),
      ),
    );
  }
}
