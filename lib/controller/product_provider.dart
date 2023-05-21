import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;

  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  List<dynamic> get shoeSizes => _shoeSizes;

  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[index]['isSelected'] = !_shoeSizes[index]['isSelected'];
        notifyListeners();
      }
    }
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  int get activePage => _activePage;

  set activePage(int value) {
    _activePage = value;
    notifyListeners();
  }
}
