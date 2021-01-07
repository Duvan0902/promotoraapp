import 'package:flutter/material.dart';

class EducationsPage extends StatelessWidget {
  const EducationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _titleEducation(context),
        ],
      ),
    );
  }

  Widget _titleEducation(context) {
    return Text(
      'Te brindamos material de apoyo que te puede ayudar en tu proceso.',
      style: Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(color: Colors.white, fontSize: 17),
    );
  }
}
