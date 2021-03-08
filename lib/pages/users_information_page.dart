import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/user_model.dart';
import 'package:mi_promotora/utils/launch_url.dart';
import 'package:recase/recase.dart';

// ignore: must_be_immutable
class UsersInformationPage extends StatefulWidget {
  final UserModel user;

  UsersInformationPage(this.user);

  @override
  _UsersInformationPageState createState() => _UsersInformationPageState();
}

class _UsersInformationPageState extends State<UsersInformationPage> {
  @override
  Widget build(BuildContext context) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");

    return Container(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[900],
          title: new Text(
            "Contactos",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white, fontSize: 20),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 75),
            child: Icon(Icons.ac_unit),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        widget.user.photo == null
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: CircleAvatar(
                                  foregroundImage: NetworkImage(baseUrl +
                                      widget.user.photo.formats.small.url),
                                ),
                              ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.name.titleCase +
                                    " " +
                                    widget.user.surname.titleCase,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                widget.user.position.titleCase,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Colors.black45, fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              widget.user.description == null || widget.user.description == ''
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Text(
                            widget.user.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black45, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
              widget.user.phone1 == null || widget.user.phone1 == ''
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.user.phone1),
                              IconButton(
                                icon: Icon(
                                  Icons.call_outlined,
                                ),
                                color: MiPromotora().primaryDark,
                                iconSize: 30,
                                onPressed: () => callPhone(widget.user.phone1),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              widget.user.phone2 == null || widget.user.phone2 == ''
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.user.phone2),
                              IconButton(
                                icon: Icon(
                                  Icons.call_outlined,
                                ),
                                color: MiPromotora().primaryDark,
                                iconSize: 30,
                                onPressed: () => callPhone(widget.user.phone2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Text(
                      widget.user.email,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
