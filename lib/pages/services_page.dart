import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/common/settings_menu.dart';
import 'package:mi_promotora/common/drawer.dart';
import 'package:mi_promotora/models/atac_model.dart';
import 'package:mi_promotora/pages/services_detailed_page.dart';
import 'package:mi_promotora/providers/service_provider.dart';
import 'package:mi_promotora/utils/random_color.dart';

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
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
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
        return _serviceCategoryItem(services[index]);
      },
    );
  }

  Widget _serviceCategoryItem(AtacModel category) {
    final String _url = GlobalConfiguration().getValue("api_url");

    return InkWell(
      child: ClipRect(
        child: Container(
          height: 150.0,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: generateRandomColor(),
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
                child: IconButton(
                  color: Colors.black,
                  icon: Image.network(
                    _url + category.icon.url,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicesDetailedPage(
                          categoriesAtac: category.atacCategories,
                          atac: category,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0)
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicesDetailedPage(
              categoriesAtac: category.atacCategories,
              atac: category,
            ),
          ),
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
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[900],
        title: Text("Servicios",
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: Colors.white, fontSize: 20)),
        actions: [PopupButton()],
      )),
    );
  }
}
