import 'package:flutter/material.dart';
import 'package:mi_promotora/bloc/customers_bloc.dart';
import 'package:mi_promotora/common/customer_item.dart';
import 'package:mi_promotora/common/settings_menu.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/models/portfolio_model.dart';
import 'package:mi_promotora/models/user_model.dart';
import 'package:mi_promotora/providers/portfolio_provider.dart';
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
      {"title": 'Para contactar', "widget": _newCustomers(context)},
      {"title": "Contactados", "widget": _followingCustomers(context)}
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
    final _portfolioProvider = PortfolioProvider();
    return Container(
      child: FutureBuilder(
        future: _portfolioProvider.getPortfolio(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PortfolioModel>> snapshot) {
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
    final _portfolioProvider = PortfolioProvider();
    return Container(
      child: FutureBuilder(
        future: _portfolioProvider.getContactedCustomers(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PortfolioModel>> snapshot) {
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

  Widget _customersList(List<PortfolioModel> portfolioContacts) {
    print("Search text is: $searchText");

    List<PortfolioModel> filteredPortfolioContacts;

    if (searchText != "" && searchText != null) {
      filteredPortfolioContacts = portfolioContacts.where((contact) {
        bool isSimilar = contact.customerName.similarityTo(searchText) > 0.3;
        bool isSimilarSurname =
            contact.insurance.similarityTo(searchText) > 0.3;
        bool isContained = contact.customerName
            .toLowerCase()
            .contains(this.searchText.toLowerCase());

        return isSimilar || isSimilarSurname || isContained;
      }).toList();
    } else {
      filteredPortfolioContacts = portfolioContacts;
    }

    return ListView.builder(
      itemCount: filteredPortfolioContacts.length,
      itemBuilder: (context, index) {
        return CustomerItem(filteredPortfolioContacts[index]);
      },
    );
  }
}
