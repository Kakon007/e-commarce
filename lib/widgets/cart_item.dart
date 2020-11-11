import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imageurl;

  CartItems(
      {@required this.id,
      @required this.productId,
      @required this.title,
      @required this.price,
      @required this.quantity,
      @required this.imageurl});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Are You Sure?"),
            content: Text("Remove the item From Cart!"),
            actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Yes")),
                  FlatButton(onPressed: (){
                     Navigator.of(context).pop(false);
                  }, child: Text("No"))
              
            ],
          ),
        );
      },
      onDismissed: (direction) {
        cart.removeCartItem(productId);
      },
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.all(10),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.network(imageurl),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${(price * quantity)}"),
            trailing: Text("Amount of goods: " + quantity.toString() + "x"),
          ),
        ),
      ),
    );
  }
// //////Show Alter Dia
//   showAlertDialog(BuildContext context) {
//     // set up the button
//     Widget okButton = FlatButton(
//       child: Text("OK"),
//       onPressed: () {},
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("Reduce Goods"),
//       content: Text("Are You Sure?"),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
}
