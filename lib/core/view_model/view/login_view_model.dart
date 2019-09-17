import 'package:flutter/widgets.dart';
import 'package:smart_home_final/core/services/authentication_service.dart';
import 'package:smart_home_final/core/view_model/base_model.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService;

  LoginViewModel({
    @required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  Future<bool> login(String userIdText) async {
    setBusy(true);
    var userId = int.tryParse(userIdText);
    var success = await _authenticationService.login(userId);
    print('success: $success');
    setBusy(false);
    return success;
  }
}
