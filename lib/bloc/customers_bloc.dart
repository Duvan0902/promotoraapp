import 'dart:async';
import 'package:mi_promotora/models/user_model.dart';
import 'package:mi_promotora/bloc/validators.dart';

class UserEvent {
  final UserModel customer;
  UserEvent(this.customer);
}

class AddCustomer extends UserEvent {
  AddCustomer(UserModel customer) : super(customer);
}

class RemoveCustomer extends UserEvent {
  RemoveCustomer(UserModel customer) : super(customer);
}

class ClearCustomers extends UserEvent {
  ClearCustomers() : super(null);
}

class CustomerBloc with Validators {
  List<UserModel> _selectedUsers = [];

  StreamController<UserEvent> _user = StreamController();
  StreamController<List<UserModel>> _users = StreamController();

  StreamSink<UserEvent> get addUserEvent => _user.sink;
  Stream<List<UserModel>> get selectedUsersStream => _users.stream;

  CustomerBloc() {
    _user.stream.listen(_onEvent);
  }

  void dispose() {
    _user.close();
    _users.close();
  }

  void _onEvent(UserEvent userEvent) {
    if (userEvent is AddCustomer) {
      _selectedUsers.add(userEvent.customer);
    }
    if (userEvent is RemoveCustomer) {
      _selectedUsers.remove(userEvent.customer);
    }

    if (userEvent is ClearCustomers) {
      _selectedUsers = [];
    }

    _users.add(_selectedUsers);
  }
}
