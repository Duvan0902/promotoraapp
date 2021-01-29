import 'package:flutter/material.dart';
import 'package:mi_promotora/common/drawer.dart';
import 'package:mi_promotora/models/atac_model.dart';
import 'package:mi_promotora/providers/service_provider.dart';

import 'services_View.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: _topBar(context),
        drawer: CustomDrawer(),
        body: Container(
          color: Colors.grey[900],
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              _description(context),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: _service(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _description(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        'Tu opinión es muy importante para nosotros, selecciona las categorías de servicios en las que te gustaría recibir capacitación.',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.white, fontSize: 17),
      ),
    );
  }

  Widget _service(context) {
    final servicesProvider = ServicesProvider();
    return Container(
      child: FutureBuilder(
        future: servicesProvider.getService(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _servicesList(snapshot.data);
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

  Widget _servicesList(List<AtacModel> services) {
    return GridView.builder(
      itemCount: services.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return ServicesView(
          atac: services[index],
        );
      },
    );
  }

  Widget _topBar(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    double barHeight = currentOrientation == Orientation.portrait ? 60 : 50;
    return PreferredSize(
      preferredSize: Size(screenWidth, barHeight),
      child: Container(
        child: AppBar(
          backgroundColor: Colors.grey[900],
          title: new Text("ATAC"),
        ),
      ),
    );
  }
}
