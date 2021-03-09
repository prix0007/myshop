import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widget/order_item.dart';
import '../widget/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderContext = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return OrderItem(order: orderContext.order[i]);
        },
        itemCount: orderContext.order.length,
      ),
    );
  }
}
