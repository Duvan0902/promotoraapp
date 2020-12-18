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
      color: Colors.grey[900],
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          _description(context),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: _service(context),
          )
        ],
      ),
    );
  }

  Widget _description(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        'Tu opinión es muy importante para nosotros, selecciona las categorias de servicios en las que te gustaria recibir capacitacion',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.white, fontSize: 17.3),
      ),
    );
  }

  Widget _service(context) {
    final servicesProvider = ServicesProvider();
    return Container(
      padding: EdgeInsets.fromLTRB(00, 00, 0, 100),
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
