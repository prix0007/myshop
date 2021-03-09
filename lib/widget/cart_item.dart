import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem(
      {this.id, this.productId, this.price, this.quantity, this.title, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(
          productId,
        );
      },
      child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: Padding(
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: FittedBox(
                    child: Text('\$${price}'),
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total : \$${price * quantity}'),
              trailing: Text('$quantity x'),
            ),
            padding: EdgeInsets.all(8),
          )),
    );
  }
}
