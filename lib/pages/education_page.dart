import 'package:flutter/material.dart';
import 'package:mi_promotora/common/settings_menu.dart';
import 'package:mi_promotora/common/drawer.dart';
import 'package:mi_promotora/models/education_model.dart';
import 'package:mi_promotora/pages/education_detailed_page.dart';
import 'package:mi_promotora/providers/education_provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/utils/random_color.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({
    Key key,
  }) : super(key: key);

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final String _url = GlobalConfiguration().getValue("api_url");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(context),
      drawer: CustomDrawer(),
      body: Container(
        color: Colors.grey[900],
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Te brindamos material de apoyo que te puede ayudar en tu proceso.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontSize: 17),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _education(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _education(context) {
    final educationProvider = EducationProvider();
    return Container(
      child: FutureBuilder(
        future: educationProvider.getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _educationList(snapshot.data);
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

  Widget _educationList(List<EducationModel> education) {
    return GridView.builder(
      itemCount: education.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return _educationView(
          education[index],
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
      child: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[900],
        title: Text(
          "Educación",
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.white, fontSize: 20),
        ),
        actions: [
          PopupButton(),
        ],
      ),
    );
  }

  Widget _educationView(EducationModel education) {
    return InkWell(
      child: ClipRect(
        child: Container(
          height: 150.0,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: generateRandomColor(),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
                child: Image.network(
                  _url + education.icon.url,
                  color: Colors.black,
                  width: 30,
                  height: 30,
                  scale: 1,
                ),
              ),
              Text(
                education.module,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
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
            builder: (context) => EducationDetailedPage(complement: education),
          ),
        );
      },
    );
  }
}
