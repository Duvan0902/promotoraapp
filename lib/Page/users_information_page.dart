import 'package:flutter/material.dart';
import 'package:promotoraapp/main.dart';

// ignore: must_be_immutable
class UsersInformationPage extends StatefulWidget {
  String na;
  String sur;
  String pos;
  String des;
  String ema;
  String pho1;
  String pho2;
  UsersInformationPage(
      this.na, this.sur, this.pos, this.des, this.ema, this.pho1, this.pho2);

  @override
  _UsersInformationPageState createState() => _UsersInformationPageState();
}

class _UsersInformationPageState extends State<UsersInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
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
        body: Container(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            child: _posterTitle(context),
          ),
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        widget.na,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.sur,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.pos,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 70),
              child: Text(
                widget.des,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black45, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.pho1),
                  IconButton(
                    icon: Icon(
                      Icons.call_outlined,
                    ),
                    color: PromotoraApp().primaryDark,
                    iconSize: 30,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.pho2),
                  IconButton(
                    icon: Icon(
                      Icons.call_outlined,
                    ),
                    color: PromotoraApp().primaryDark,
                    iconSize: 30,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 49),
              child: Container(
                  child: Text(
                widget.ema,
                textAlign: TextAlign.left,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
