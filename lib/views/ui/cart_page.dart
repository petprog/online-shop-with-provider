import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop_with_provider/controller/cart_provider.dart';
import 'package:online_shop_with_provider/views/shared/app_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_shop_with_provider/views/shared/checkout_btn.dart';
import 'package:provider/provider.dart';

import '../shared/empty_placeholder.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartNotifier = Provider.of<CartNotifier>(context, listen: true);
    cartNotifier.getCart();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appStyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Consumer<CartNotifier>(
                      builder: (context, cartNotifier, child) {
                    final cart = cartNotifier.cart;
                    // empty icon

                    return cart.isEmpty
                        ? const Center(
                            child: EmptyPlaceholder(
                              label: 'Your cart is empty',
                            ),
                          )
                        : ListView.builder(
                            itemCount: cart.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final data = cart[index];
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 1,
                                          onPressed: (context) {
                                            cartNotifier.remove(data['id']);
                                          },
                                          backgroundColor:
                                              const Color(0xFF000000),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.11,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade500,
                                                    spreadRadius: 5,
                                                    blurRadius: 0.3,
                                                    offset: const Offset(0, 1)),
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          data['imageUrl'],
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12, left: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data['name'],
                                                          style: appStyle(
                                                              16,
                                                              Colors.black,
                                                              FontWeight.bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          data['category'],
                                                          style: appStyle(
                                                              14,
                                                              Colors.grey,
                                                              FontWeight.w600),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              data['price'],
                                                              style: appStyle(
                                                                  18,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                            const SizedBox(
                                                              width: 40,
                                                            ),
                                                            Text(
                                                              "Size",
                                                              style: appStyle(
                                                                  18,
                                                                  Colors.grey,
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Text(
                                                              data['sizes'],
                                                              style: appStyle(
                                                                  18,
                                                                  Colors.grey,
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16))),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                cartNotifier
                                                                    .decrement(
                                                                        data[
                                                                            'id']);
                                                              },
                                                              child: const Icon(
                                                                AntDesign
                                                                    .minussquare,
                                                                size: 20,
                                                                color:
                                                                    Colors.grey,
                                                              )),
                                                          Text(
                                                            "${data['qty']}",
                                                            style: appStyle(
                                                              16,
                                                              Colors.black,
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                cartNotifier
                                                                    .increment(
                                                                        data[
                                                                            'id']);
                                                              },
                                                              child: const Icon(
                                                                AntDesign
                                                                    .plussquare,
                                                                size: 20,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: InkWell(
                                            onTap: () {
                                              cartNotifier.remove(data['id']);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                  }),
                )
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(label: 'Proceed to Checkout'),
            )
          ],
        ),
      ),
    );
  }
}
