import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widget/order_item.dart';
import '../widget/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error == null) {
                return Consumer<Orders>(
                  builder: (ctx, orderContext, _) => ListView.builder(
                    itemBuilder: (ctx, i) {
                      return OrderItem(order: orderContext.order[i]);
                    },
                    itemCount: orderContext.order.length,
                  ),
                );
              } else {
                // Do Error handling here...
                return Center(
                  child: Text('An Error Occured'),
                );
              }
            }
          },
        ));
  }
}
