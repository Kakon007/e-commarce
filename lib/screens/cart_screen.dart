import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/order.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total"),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      cart.totalamount.toStringAsFixed(2),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      order.addOrder(
                          cart.item.values.toList(), cart.totalamount);
                      cart.colseCart();
                      
                    },
                    child: Text(
                      "Oder Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.item.length,
              itemBuilder: (context, i) => CartItems(
                id: cart.item.values.toList()[i].id,
                productId: cart.item.keys.toList()[i],
                title: cart.item.values.toList()[i].title,
                price: cart.item.values.toList()[i].price,
                quantity: cart.item.values.toList()[i].quantity,
                imageurl: cart.item.values.toList()[i].imageurl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/provider/cart.dart';

// class CartScreen extends StatelessWidget {
//   final String id;
//   final String title;
//   CartScreen({this.id,this.title});
//   @override
//   Widget build(BuildContext context) {
//     //List<Cart> list=[];
//     //final cart= Provider.of<Cart>(context);
//     final cart = Provider.of<CartItem>(context);
//     var le = int.parse(cart.id);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: le.bitLength,
//         itemBuilder: (context, index) => Consumer<Cart>(
//           builder: (context, data, child) => ListTile(
//             title: data.item,
//           ),
//         ),
//       ),
//     );
//   }
// }
