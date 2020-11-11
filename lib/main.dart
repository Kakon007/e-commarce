import 'package:flutter/material.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/order.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/product_details_overview.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => Product(),
        ),
        ChangeNotifierProvider(create: (c) => Cart()),
        //ChangeNotifierProvider(create:(c) => CartItem()),
        ChangeNotifierProvider(create: (c) => Order()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple, accentColor: Colors.deepOrange),
        home: ProductOverView(),
        routes: {ProductDetails.routeName: (context) => ProductDetails(),
        EditProductScreen.routeName:(context)=>EditProductScreen()
        },
      ),
    );
  }
}
