import 'package:ankmei_app/custom_object/user.dart';
import 'package:flutter/foundation.dart';

class CurrentUserStore extends ChangeNotifier {
  CurrentUserStore._internal();
  static final CurrentUserStore instance = CurrentUserStore._internal();

  String? _token;
  User? _user;

  String? get token => _token;
  User? get user => _user;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  void setTokenAndUser({required String token, required User user}) {
    _token = token;
    _user = user;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clear() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}


