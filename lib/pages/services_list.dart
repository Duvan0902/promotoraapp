import 'package:flutter/material.dart';
import 'package:MiPromotora/pages/services_View.dart';
import 'package:MiPromotora/models/atac_model.dart';

class ServicesList extends StatelessWidget {
  final List<AtacModel> services;

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
