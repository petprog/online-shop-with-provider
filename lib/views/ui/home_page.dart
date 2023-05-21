// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:online_shop_with_provider/controller/products_provider.dart';
import 'package:online_shop_with_provider/views/shared/app_style.dart';
import 'package:provider/provider.dart';
import '../shared/assets_constants.dart';
import '../shared/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    var productsNotifier = Provider.of<ProductsNotifier>(context);
    productsNotifier.getMenSneakersList();
    productsNotifier.getWomenSneakersList();
    productsNotifier.getKidsSneakersList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(Assets.topImage),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Athletics Shoes',
                          style:
                              appStyle(42, Colors.white, FontWeight.bold, 1.5),
                        ),
                        Text(
                          'Collection',
                          style:
                              appStyle(42, Colors.white, FontWeight.bold, 1.2),
                        ),
                        TabBar(
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appStyle(24, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: const [
                            Tab(text: "Men  Shoes"),
                            Tab(text: "Women  Shoes"),
                            Tab(text: "Kids  Shoes"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.22,
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      HomeView(
                        list: productsNotifier.menSneakersList,
                        tabIndex: 0,
                      ),
                      HomeView(
                        list: productsNotifier.womenSneakersList,
                        tabIndex: 1,
                      ),
                      HomeView(
                        list: productsNotifier.kidsSneakersList,
                        tabIndex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
