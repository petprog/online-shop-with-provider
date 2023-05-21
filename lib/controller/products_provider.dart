import 'package:flutter/cupertino.dart';

import '../models/sneakers_model.dart';
import '../services/helper.dart';

class ProductsNotifier extends ChangeNotifier {
  late Future<List<Sneakers>> _menSneakersList;
  late Future<List<Sneakers>> _womenSneakersList;
  late Future<List<Sneakers>> _kidsSneakersList;

  // get
  Future<List<Sneakers>> get menSneakersList => _menSneakersList;
  Future<List<Sneakers>> get womenSneakersList => _womenSneakersList;
  Future<List<Sneakers>> get kidsSneakersList => _kidsSneakersList;

  void getMenSneakersList() {
    _menSneakersList = Helper().getSneakersByType('men');
  }

  void getWomenSneakersList() {
    _womenSneakersList = Helper().getSneakersByType('women');
  }

  void getKidsSneakersList() {
    _kidsSneakersList = Helper().getSneakersByType('kids');
  }
}
