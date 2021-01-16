import 'package:flutter/material.dart';
import 'package:promotoraapp/common/drawer.dart';
import 'package:promotoraapp/pages/education_list.dart';
import 'package:promotoraapp/providers/education_provider.dart';

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
              Container(
                  padding: EdgeInsets.all(10), child: _titleEducation(context)),
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
          .bodyText2
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
            return EducationList(education: snapshot.data);
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

  Widget _topBar(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    double barHeight = currentOrientation == Orientation.portrait ? 60 : 50;
    return PreferredSize(
      preferredSize: Size(screenWidth, barHeight),
      child: Container(
        child: AppBar(
          backgroundColor: Colors.grey[900],
          title: new Text("Educación"),
        ),
      ),
    );
  }
}