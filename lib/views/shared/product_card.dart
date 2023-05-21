import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop_with_provider/controller/favorites_provider.dart';
import 'package:online_shop_with_provider/views/ui/favorites_page.dart';
import 'package:provider/provider.dart';

import 'app_style.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String id;
  final String price;
  final String category;
  final String imageUrl;
  const ProductCard(
      {super.key,
      required this.name,
      required this.id,
      required this.price,
      required this.category,
      required this.imageUrl});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    bool selected = true;
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.64,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.imageUrl))),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Consumer<FavoritesNotifier>(
                      builder: (context, favoritesNotifier, child) =>
                          GestureDetector(
                        onTap: () async {
                          if (favoritesNotifier.isFavorite(widget.id)) {
                            //Navigation push
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FavoritesPage()));
                          } else {
                            await favoritesNotifier.createFavorite({
                              "id": widget.id,
                              "name": widget.name,
                              'category': widget.category,
                              "price": widget.price,
                              "imageUrl": widget.imageUrl,
                            });
                          }
                          setState(() {});
                        },
                        child: favoritesNotifier.isFavorite(widget.id)
                            ? const Icon(MaterialCommunityIcons.heart)
                            : const Icon(MaterialCommunityIcons.heart_outline),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appStyle(36, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style: appStyle(18, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appStyle(30, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          "Colors",
                          style: appStyle(18, Colors.grey, FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ChoiceChip(
                          label: const Text(" "),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
