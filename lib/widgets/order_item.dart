import 'package:flutter/material.dart';
import 'package:shop_app/provider/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItems extends StatefulWidget {
  final OrderItem order;

  OrderItems({this.order});

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.order.amount.toStringAsFixed(2)),
            subtitle: Text(
              DateFormat("dd-MM-yyyy  hh:mm").format(widget.order.dateTime),
            ),
            trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView(
                children: widget.order.products
                    .map((prod) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Text(
                              prod.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              ' ${prod.quantity}x \$${prod.price}',
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.right,
                            )
                          ],
                        ),
                        )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
