import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/services.dart';
import 'package:promotoraapp/Model/services_model.dart';

class ServicesList extends StatelessWidget {
  final List<ServicesModel> services;

  ServicesList({@required this.services});
  @override
  Widget build(BuildContext context) {
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
}
