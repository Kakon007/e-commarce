import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/order.dart';
import 'package:shop_app/widgets/app_dawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderdata = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDawer(),
      body: ListView.builder(
        itemCount: orderdata.order.length,
        itemBuilder: (ctx, i) => OrderItems(
          
          order: orderdata.order[i],
        ),
      ),
    );
  }
}
