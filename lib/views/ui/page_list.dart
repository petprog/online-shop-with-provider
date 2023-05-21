import 'package:flutter/material.dart';
import 'package:online_shop_with_provider/views/ui/favorites_page.dart';
import 'package:online_shop_with_provider/views/ui/profile.dart';
import 'package:online_shop_with_provider/views/ui/search_page.dart';

import 'cart_page.dart';
import 'home_page.dart';

List<Widget> pageList = [
  const HomePage(),
  const SearchPage(),
  const FavoritesPage(),
  const CartPage(),
  const Profile(),
];
