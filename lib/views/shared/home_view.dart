import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop_with_provider/controller/product_provider.dart';
import 'package:online_shop_with_provider/views/shared/product_card.dart';
import 'package:online_shop_with_provider/views/ui/product_by_category.dart';
import 'package:online_shop_with_provider/views/ui/product_page.dart';
import 'package:provider/provider.dart';

import '../../models/sneakers_model.dart';
import 'app_style.dart';
import 'new_shoe.dart';

class HomeView extends StatelessWidget {
  final int tabIndex;
  final Future<List<Sneakers>> list;
  const HomeView({Key? key, required this.list, required this.tabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder(
            future: list,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final list = snapshot.data!;
                return ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final sneakers = list[index];

                    return InkWell(
                      onTap: () {
                        productNotifier.shoeSizes = sneakers.sizes;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(sneaker: sneakers),
                          ),
                        );
                      },
                      child: ProductCard(
                          name: sneakers.name,
                          id: sneakers.id,
                          price: '\$${sneakers.price}',
                          category: sneakers.category,
                          imageUrl: sneakers.imageUrl[0]),
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Shoes',
                    style: appStyle(24, Colors.black, FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCategory(
                            tabIndex: tabIndex,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appStyle(22, Colors.black, FontWeight.w500),
                        ),
                        const Icon(AntDesign.caretright, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: FutureBuilder(
            future: list,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final menSneakersList = snapshot.data!;
                return ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final sneakers = menSneakersList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewShoe(
                        imageUrl: sneakers.imageUrl[1],
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
