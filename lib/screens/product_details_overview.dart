import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';

class ProductDetails extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  // ProductDetails(this.imageUrl, this.title);

  static const routeName = "/product-details";

  @override
  Widget build(BuildContext context) {
    final productID =
        ModalRoute.of(context).settings.arguments as String; //is product id..
    final loadedProduct =
        Provider.of<Product>(context, listen: false).findById(productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\$${(loadedProduct.price)}",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
                child: Text(
              loadedProduct.description,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            )
          ],
        ),
      ),
    );
  }
}
