import 'package:flutter/material.dart';
import 'package:promotoraapp/Model/education_model.dart';

class EducationComplementPage extends StatefulWidget {
  final EducationModel complement;
  EducationComplementPage({Key key, this.complement}) : super(key: key);

  @override
  _EducationComplementPageState createState() =>
      _EducationComplementPageState();
}

class _EducationComplementPageState extends State<EducationComplementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey[900],
          title: Text(
            "Educación",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 18),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              _titleEducation(),
              SizedBox(
                height: 10,
              ),
              _videoPlayer(),
              _audioPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleEducation() {
    return Text('Te brindamos material de apoyo que te ayudara con tu proceso');
  }

  Widget _videoPlayer() {
    return Container();
  }

  Widget _audioPlayer() {
    return Card(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.complement.podcastFile.name),
                SizedBox(
                  height: 10,
                ),
                Text(widget.complement.podcastFile.caption)
              ],
            ),
          ),
          SizedBox(width: 40),
        ],
      ),
    );
  }
}
