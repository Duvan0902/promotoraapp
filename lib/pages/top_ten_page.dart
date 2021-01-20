import 'package:flutter/material.dart';

class TopTenPage extends StatelessWidget {
  const TopTenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[900],
          title: new Text(
            "Top 10",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 20),
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 75),
            child: Icon(Icons.ac_unit),
          ),
        ),
      ),
    );
  }
}
