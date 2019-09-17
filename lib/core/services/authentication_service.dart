import 'dart:async';

import 'package:smart_home_final/core/model/user.dart';
import 'package:smart_home_final/core/services/api.dart';

class AuthenticationService {
  final Api _api;

  AuthenticationService({Api api}) : _api = api;

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserById(userId);
    print('user: ${fetchedUser.toRawJson()}');
    if (fetchedUser != null) {
      _userController.add(fetchedUser);
      return true;
    }
    return false;
  }
}
