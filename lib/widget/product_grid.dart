import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool _showOnlyFavorites;

  ProductGrid(this._showOnlyFavorites);

  @override
  Widget build(BuildContext context) {
    final productsContext = Provider.of<Products>(context);
    var products = _showOnlyFavorites
        ? productsContext.favoriteItems
        : productsContext.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
