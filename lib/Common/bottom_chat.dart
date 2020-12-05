import 'package:flutter/material.dart';

class BottomChat extends StatelessWidget {
  const BottomChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: Colors.pink[400],
          elevation: 5.0,
          child: Icon(
            Icons.chat,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
