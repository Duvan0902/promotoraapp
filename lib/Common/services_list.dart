import 'package:flutter/material.dart';
import 'package:promotoraapp/Common/sevices.dart';
import 'package:promotoraapp/Model/services_model.dart';

class ServicesList extends StatelessWidget {
  final List<ServicesModel> services;

  ServicesList({@required this.services});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ServicesView(
            category: services[index].category,
          );
        },
      ),
    );
  }
}
