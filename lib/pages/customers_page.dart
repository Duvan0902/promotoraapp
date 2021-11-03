import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mi_promotora/bloc/customers_bloc.dart';
import 'package:mi_promotora/common/settings_menu.dart';
import 'package:mi_promotora/models/contact_model_interface.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/user_model.dart';
import 'package:mi_promotora/pages/contact_information_page.dart';
import 'package:mi_promotora/providers/contacts_provider.dart';
import 'package:mi_promotora/utils/alert_dialog.dart';
import 'package:mi_promotora/utils/launch_url.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:recase/recase.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key key}) : super(key: key);

  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage>
    with SingleTickerProviderStateMixin {
  CustomerBloc _customerBloc = CustomerBloc();

  AnimationController _animationController;
  Animation _animation;
  int _selectedTab = 0;

  Widget _currentWidget;
  String searchText;

  SearchBar searchBar;
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      title: Text("Gestiona tu cartera",
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.white, fontSize: 20)),
      actions: [
        searchBar.getSearchAction(context),
        PopupButton(),
      ],
      backgroundColor: Colors.grey[900],
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void clearSearch() {
    setState(() {
      searchText = "";
    });
  }

  void search(String value) {
    print(value);
    setState(() {
      searchText = value;
      _currentWidget = _currentWidget;
    });
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _customerBloc.dispose();
    _animationController.dispose();
    super.dispose();
  }

  _CustomersPageState() {
    searchBar = SearchBar(
      inBar: false,
      setState: setState,
      onChanged: search,
      onCleared: clearSearch,
      onClosed: clearSearch,
      buildDefaultAppBar: buildAppBar,
      hintText: 'Buscar contacto',
    );
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    List<Map<String, dynamic>> tabs = [
      {"title": 'Nuevos clientes', "widget": _newCustomers(context)},
      {"title": "Seguimiento", "widget": _followingCustomers(context)}
    ];
    if (_currentWidget == null) {
      _currentWidget = _newCustomers(context);
    }

    return Container(
      child: Scaffold(
        appBar: searchBar.build(context),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: tabs.map((tab) {
                  int currentIndex = tabs.indexOf(tab);
                  bool selected = currentIndex == _selectedTab;

                  Function onTabFunction = () {
                    setState(() {
                      _selectedTab = currentIndex;
                      _currentWidget = tab['widget'];
                      _animationController.repeat();
                    });
                  };

                  return _tab(tab["title"], onTabFunction, selected);
                }).toList(),
              ),
            ),
            Expanded(
              child: FadeTransition(opacity: _animation, child: _currentWidget),
            ),
          ],
        ),
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Widget _tab(String title, Function onTap, selected) {
    double borderRadius = 10;
    double width = (MediaQuery.of(context).size.width / 2) - 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: selected ? Colors.white : MiPromotora().primaryDark,
          border: Border.all(
            color: Color.fromRGBO(243, 243, 243, 1),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: selected ? Colors.black : Colors.black,
              fontWeight: FontWeight.w800),
        ),
        width: width,
      ),
    );
  }

  Widget _newCustomers(context) {
    final contactProviders = ContactsProvider();
    return Container(
      child: FutureBuilder(
        future: contactProviders.getUserContacts(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            _animationController.forward();
            return _customersList(snapshot.data);
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

  Widget _followingCustomers(context) {
    final contactProvider = ContactsProvider();
    return Container(
      child: FutureBuilder(
        future: contactProvider.getContacts(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ContactModelInterface>> snapshot) {
          if (snapshot.hasData) {
            _animationController.forward();
            return _customersList(snapshot.data);
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

  Widget _customersList(List<ContactModelInterface> contacts) {
    print("Search text is: $searchText");

    List<ContactModelInterface> filteredListContacts;

    if (searchText != "" && searchText != null) {
      filteredListContacts = contacts.where((contact) {
        bool isSimilar = contact.name.similarityTo(searchText) > 0.3;
        bool isSimilarSurname = contact.surname.similarityTo(searchText) > 0.3;
        bool isContained =
            contact.name.toLowerCase().contains(this.searchText.toLowerCase());

        return isSimilar || isSimilarSurname || isContained;
      }).toList();
    } else {
      filteredListContacts = contacts;
    }

    return StreamBuilder<List<UserModel>>(
      stream: _customerBloc.selectedUsersStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        Widget selectedUsersWidget = SizedBox();
        List<UserModel> selectedCustomers = [];

        if (snapshot.hasData) {
          selectedCustomers = snapshot.data;
          if (selectedCustomers.length > 0) {
            selectedUsersWidget = Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  _sendMessages(selectedCustomers);
                },
                highlightColor: MiPromotora().accent,
                child: Container(
                  color: MiPromotora().grey,
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 20, bottom: 40, right: 30, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enviar mensaje a ${selectedCustomers.length} usuario(s)",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                      FaIcon(
                        FontAwesomeIcons.arrowRight,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }

        return Stack(children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: selectedCustomers.length > 0 ? 75 : 0,
              ),
              child: ListView.builder(
                itemCount: filteredListContacts.length,
                itemBuilder: (context, index) {
                  return ContactItem(
                      filteredListContacts[index], _customerBloc);
                },
              ),
            ),
          ),
          selectedUsersWidget
        ]);
      },
    );
  }

  Future<void> _sendMessages(List<UserModel> customers) async {
    Widget confirmateAlertDialog = AlertDialog(
      title: const Text('Enviar mensaje'),
      content: Column(
        children: [
          Text(
              "¿Enviar mensaje a ${customers.length} usuario(s) seleccionados?"),
          Text(
              "Previsualizaciòn del mensaje: Hola Andrès, hablas con tu asesor de seguro Sura.")
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Enviar'),
          onPressed: () {
            for (var customer in customers) {
              String _message =
                  "Hola ${customer.name}, hablas con tu asesor de seguro Sura.";
              String _url =
                  "https://api.whatsapp.com/send?phone=${customer.phone1}&text=$_message";
              try {
                launchUrl(_url);
              } catch (Exception) {
                print("It wasn't possible to launch whatsapp in your mobile");
              }
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return confirmateAlertDialog;
      },
    );
  }
}

class ContactItem extends StatefulWidget {
  final UserModel contact;
  final CustomerBloc customerBloc;

  ContactItem(this.contact, this.customerBloc, {Key key}) : super(key: key);

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listTile = Flexible(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.contact.name.titleCase +
              " " +
              widget.contact.surname.titleCase,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black, fontSize: 16),
        ),
        SizedBox(height: 5),
        Text(
          widget.contact.company.titleCase,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black45, fontSize: 15),
        ),
      ],
    ));

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 3, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                listTile,
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.call_outlined,
                      ),
                      color: MiPromotora().primaryDark,
                      iconSize: 30,
                      onPressed: () => callPhone(widget.contact.phone1),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                      ),
                      color: MiPromotora().primaryDark,
                      iconSize: 30,
                      onPressed: () => callPhone(widget.contact.phone1),
                    ),
                    Checkbox(
                      value: _isChecked,
                      checkColor: Colors.white,
                      onChanged: (bool value) {
                        if (value) {
                          widget.customerBloc.addUserEvent
                              .add(AddCustomer(widget.contact));
                        } else {
                          widget.customerBloc.addUserEvent
                              .add(RemoveCustomer(widget.contact));
                        }
                        setState(() {
                          _isChecked = value;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactInformationPage(widget.contact),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
