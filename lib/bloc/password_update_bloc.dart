import 'dart:async';
import 'package:mi_promotora/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class PasswordUpdateBloc with Validators {
  final _newPasswordController = BehaviorSubject<String>();
  final _newPasswordConfirmationController = BehaviorSubject<String>();
  final _newPasswordCheckController = BehaviorSubject<String>();

  Stream<String> get newPasswordStream =>
      _newPasswordController.stream.transform(validatePassword);
  Stream<String> get newPasswordCheckStream =>
      _newPasswordConfirmationController.stream
          .transform(validatePassword)
          .doOnData((newConfirmationPass) {
        if (_newPasswordController.value.compareTo(newConfirmationPass) != 0) {
          _newPasswordConfirmationController
              .addError("Las contraseñas no coinciden");
        }
      });

  Stream<bool> get checkNewPasswordsStream =>
      Rx.combineLatest2(newPasswordStream, newPasswordCheckStream, (p, n) {
        return true;
      });

  String get newPassword => _newPasswordConfirmationController.value;
  String get newPasswordConfirmation =>
      _newPasswordConfirmationController.value;
  String get passwordCheck => _newPasswordCheckController.value;

  Function(String) changeNewPassword() => _newPasswordController.sink.add;
  Function(String) changeNewPasswordConfirmation() =>
      _newPasswordConfirmationController.sink.add;

  dispose() {
    _newPasswordController?.close();
    _newPasswordConfirmationController?.close();
    _newPasswordCheckController?.close();
  }
}
