import 'package:flutter/material.dart';
import 'package:flutter_app/models/person.dart';

import 'db_service.dart';

class AppState with ChangeNotifier {
  AppState() {}
  final db = DBService.instance;
  Person? _user;

  set user(Person? person) {
    _user = person;

    notifyListeners();
    if (person != null) {
      db.addToDb(person, clear: true);
    }
  }

  Person? get user => _user;

  bool get isAuthenticated => _user != null;
}
