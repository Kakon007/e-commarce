import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';

import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_dawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/productItem.dart';

enum FliterOptions { Favourite, All }

class ProductOverView extends StatefulWidget {
  const ProductOverView({Key key}) : super(key: key);

  @override
  _ProductOverViewState createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  var _showFavourite = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FliterOptions value) {
              setState(() {
                if (value == FliterOptions.Favourite) {
                  _showFavourite = true;
                } else {
                  _showFavourite = false;
                }
              });

              print(value);
            },
            itemBuilder: (c) => [
              PopupMenuItem(
                child: Text(
                  "Only favourite",
                ),
                value: FliterOptions.Favourite,
              ),
              PopupMenuItem(
                child: Text(
                  "All products",
                ),
                value: FliterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartdata, ch) => Badge(
              child: ch,
              value: cartdata.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
              },
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: AppDawer(),
      body: ProductGrid(_showFavourite),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final bool showfav;
  ProductGrid(this.showfav);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context);
    final product = showfav ? productData.favitems : productData.item;
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: product[index],
        child: ProductItem(
            // product[index].id, product[index].title, product[index].imageUrl
            ),
      ),
      itemCount: product.length,
    );
  }
}
