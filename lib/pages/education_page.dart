import 'package:flutter/material.dart';
import 'package:mi_promotora/common/Popup_Menu_Button.dart';
import 'package:mi_promotora/common/drawer.dart';
import 'package:mi_promotora/models/education_model.dart';
import 'package:mi_promotora/providers/education_provider.dart';

import 'education_view.dart';

class EducationsPage extends StatefulWidget {
  const EducationsPage({
    Key key,
  }) : super(key: key);

  @override
  _EducationsPageState createState() => _EducationsPageState();
}

class _EducationsPageState extends State<EducationsPage> {
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
        return EducationView(
          education: education[index],
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
}
