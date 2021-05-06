import 'package:flutter/material.dart';

class SearchInputProvider with ChangeNotifier {
  String _searchInput = "";
  String get searchInput => _searchInput;
  set searchInput(String input) {
    _searchInput = input;
    notifyListeners();
  }
}
