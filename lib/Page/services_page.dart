import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/services_list.dart';
import 'package:promotoraapp/provider/service_provider.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(body: _service(context)),
    );
  }

  Widget _service(context) {
    final servicesProvider = ServicesProvider();
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 20, 30),
      child: FutureBuilder(
        future: servicesProvider.getService(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ServicesList(services: snapshot.data);
          } else {
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
