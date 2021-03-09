import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widget/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartContext = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cartContext.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Orders>(
                          context,
                          listen: false,
                        ).addOrder(
                          cartContext.items.values.toList(),
                          cartContext.totalAmount,
                        );
                        cartContext.clear();
                      },
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => CartItem(
                  id: cartContext.items.values.toList()[i].id,
                  productId: cartContext.items.keys.toList()[i],
                  title: cartContext.items.values.toList()[i].title,
                  quantity: cartContext.items.values.toList()[i].quantity,
                  price: cartContext.items.values.toList()[i].price,
                ),
                itemCount: cartContext.itemCount,
              ),
            )
          ],
        ));
  }
}
