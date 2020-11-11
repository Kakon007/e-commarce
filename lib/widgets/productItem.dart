import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/product_details_overview.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Products>(
            builder: (context, product, child) => IconButton(
              icon: Icon(
                  product.isfavourite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavouriteStatus();
              },
              color: Colors.deepOrange,
            ),
          ),
          title: Text(
            product.title,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                  product.id, product.title, product.price, product.imageUrl);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Added Item to the cart"),
                action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      cart.removeSingleProduct(product.id);
                    }),
                duration: Duration(seconds: 2),
              ));
            },
            color: Colors.deepOrange,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
