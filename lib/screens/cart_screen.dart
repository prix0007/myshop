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
                    OrderButton(cartContext: cartContext)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartContext,
  }) : super(key: key);

  final Cart cartContext;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cartContext.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(
                context,
                listen: false,
              ).addOrder(
                widget.cartContext.items.values.toList(),
                widget.cartContext.totalAmount,
              );
              widget.cartContext.clear();
              setState(() {
                _isLoading = false;
              });
            },
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
    );
  }
}
