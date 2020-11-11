import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageurl;

  UserProductItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.imageurl});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              leading: CircleAvatar(
                child: Image.network(imageurl),
              ),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, EditProductScreen.routeName,
                              arguments: id);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Provider.of<Product>(context).deleteProducts(id);
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
