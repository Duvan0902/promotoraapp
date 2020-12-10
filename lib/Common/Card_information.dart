import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';

class GeneralCard extends StatelessWidget {
  const GeneralCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: PromotoraApp().primaryLight,
            elevation: 2.0,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: PromotoraApp().primaryLight,
            elevation: 2.0,
          ),
        ],
      ),
    );
  }
}
