import 'package:flutter/material.dart';
import 'package:online_shop_with_provider/views/shared/product_staggered_tile.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/sneakers_model.dart';

class LatestShoes extends StatelessWidget {
  final Future<List<Sneakers>> list;
  const LatestShoes({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final list = snapshot.data!;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            itemCount: list.length,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (index) => StaggeredTile.extent(
                (index % 2 == 0) ? 1 : 1,
                (index % 4 == 1 || index % 4 == 3)
                    ? MediaQuery.of(context).size.height * 0.3
                    : MediaQuery.of(context).size.height * 0.28),
            itemBuilder: (context, index) {
              final sneakers = list[index];
              return ProductStaggeredTile(
                  name: sneakers.name,
                  price: '\$${sneakers.price}',
                  imageUrl: sneakers.imageUrl[0]);
            },
          );
        }
      },
    );
  }
}
