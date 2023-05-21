import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_shop_with_provider/controller/cart_provider.dart';
import 'package:online_shop_with_provider/controller/favorites_provider.dart';
import 'package:online_shop_with_provider/controller/products_provider.dart';
import 'package:provider/provider.dart';
import 'controller/main_screen_provider.dart';
import 'controller/product_provider.dart';
import 'views/ui/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (_) => ProductNotifier()),
        ChangeNotifierProvider(create: (_) => FavoritesNotifier()),
        ChangeNotifierProvider(create: (_) => CartNotifier()),
        ChangeNotifierProvider(create: (_) => ProductsNotifier()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
