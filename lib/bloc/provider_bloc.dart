import 'package:flutter/material.dart';
import 'package:mi_promotora/bloc/login_bloc.dart';
import 'package:mi_promotora/bloc/password_update_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }

    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final LoginBloc loginBloc = LoginBloc();
  final PasswordUpdateBloc passwordUpdateBloc = PasswordUpdateBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static PasswordUpdateBloc passwordUpdate(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        .passwordUpdateBloc;
  }
}
