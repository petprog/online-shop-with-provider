import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');

  List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> _fav = [];

// get
  List<Map<String, dynamic>> get favorites => _favorites;
  List<Map<String, dynamic>> get fav => _fav;

// set
  set favorites(List<Map<String, dynamic>> newFavorites) {
    _favorites = newFavorites;
    notifyListeners();
  }

  set fav(List<Map<String, dynamic>> newFavorites) {
    _fav = newFavorites;
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.any((element) => element['id'] == id);
  }

  void removeFavorite(String id) {
    _favorites.removeWhere((element) => element['id'] == id);
    notifyListeners();
  }

  void getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        'key': key,
        'id': item["id"],
      };
    }).toList();
    _favorites = favData;
  }

  Future<void> createFavorite(Map<String, dynamic> favorite) async {
    await _favBox.add(favorite);
  }

  void getFav() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        'key': key,
        'id': item["id"],
        'name': item["name"],
        'category': item["category"],
        'price': item["price"],
        'imageUrl': item["imageUrl"],
      };
    }).toList();
    _fav = favData.reversed.toList();
  }

  void deleteFav(int key) {
    _favBox.delete(key);
  }
}
