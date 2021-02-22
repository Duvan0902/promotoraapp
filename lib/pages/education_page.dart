import 'package:flutter/material.dart';
import 'package:mi_promotora/common/Popup_Menu_Button.dart';
import 'package:mi_promotora/common/drawer.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/education_model.dart';
import 'package:mi_promotora/pages/education_detailed_page.dart';
import 'package:mi_promotora/providers/education_provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/utils/random_color.dart';

class EducationsPage extends StatefulWidget {
  const EducationsPage({
    Key key,
  }) : super(key: key);

  @override
  _EducationsPageState createState() => _EducationsPageState();
}

class _EducationsPageState extends State<EducationsPage> {
  final String _url = GlobalConfiguration().getValue("api_url");

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
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                child: _titleEducation(context),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _education(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleEducation(context) {
    return Text(
      'Te brindamos material de apoyo que te puede ayudar en tu proceso.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Colors.white, fontSize: 17),
    );
  }

  Widget _education(context) {
    final educationProvider = EducationProvider();
    return Container(
      child: FutureBuilder(
        future: educationProvider.getEducation(),
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
      child: Container(
        child: AppBar(
          backgroundColor: Colors.grey[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Educación"),
              PopupButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _educationView(EducationModel education) {
    return InkWell(
      child: ClipRect(
        child: Container(
          height: 150.0,
          margin: EdgeInsets.all(8.0),
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
