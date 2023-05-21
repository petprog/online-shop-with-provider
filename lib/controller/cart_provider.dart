import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartNotifier extends ChangeNotifier {
  final _cartBox = Hive.box('cart_box');

  final int _counter = 1;
  List<Map<String, dynamic>> _cart = [];

  // get
  int get counter => _counter;
  List<Map<String, dynamic>> get cart => _cart;

  void increment(String id) {
    for (var item in _cart) {
      if (item['id'] == id) {
        item['qty'] = (item['qty'] ?? 0) + 1;
        _cartBox.put(item['key'], item);
      }
    }
    notifyListeners();
  }

  void decrement(String id) {
    for (var item in _cart) {
      if (item['id'] == id && item['qty'] >= 1) {
        item['qty'] = (item['qty'] ?? 1) - 1;
        _cartBox.put(item['key'], item);
      }
    }
    notifyListeners();
  }

  Future<void> createCart(Map<dynamic, dynamic> newCart) async {
    for (var item in _cart) {
      if (item['id'] == newCart['id']) {
        _cartBox.delete(item['key']);
      }
    }
    await _cartBox.add(newCart);
    notifyListeners();

    // print('save to car_box');
  }

  void remove(String id) {
    for (var item in _cart) {
      if (item['id'] == id) {
        _cartBox.delete(item['key']);
      }
    }
    notifyListeners();
  }

  void getCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();

    _cart = cartData.reversed.toList();
  }
}
