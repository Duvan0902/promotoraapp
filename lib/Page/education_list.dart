import 'package:flutter/material.dart';
import 'package:promotoraapp/Page/education_view.dart';
import 'package:promotoraapp/Model/education_model.dart';

class EducationList extends StatelessWidget {
  final List<EducationModel> education;

  EducationList({@required this.education});
  @override
  Widget build(BuildContext context) {
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
}
