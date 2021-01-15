import 'package:flutter/material.dart';

class SelfManagementPage extends StatelessWidget {
  const SelfManagementPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[900],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            _title(context),
          ],
        ),
      ),
    );
  }

  Widget _title(context) {
    return Text(
      '¡Esperamos que tengas excelentes ventas! A continuación te presentamos las metas del mes.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.white, fontSize: 17),
    );
  }
}
